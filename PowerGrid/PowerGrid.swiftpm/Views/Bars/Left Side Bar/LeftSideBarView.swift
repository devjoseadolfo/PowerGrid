import SwiftUI

struct LeftSideBarView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var selectionEnable: Bool
    
    var body: some View {
        ZStack {
            if selectionEnable, let cell = grid.selectedCell {
                CellPopoverView(cell: cell)
                    .padding(32)
                    .roundedRectangleGlass(cornerRadius: 32)
                    .padding(16)
                    .transition(.opacity)
            } else {
                DynamicScrollView {
                    VStack(alignment: .center, spacing: 8) {
                        PowerInfoView()
                        DemandInfoView()
                        SunlightInfoView()
                        WindInfoView()
                    }
                    .padding(16)
                }
                .transition(.opacity)
            }
        }
        .animation(.default, value: grid.selectedCell)
       
    }
}

struct DynamicScrollView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ViewThatFits {
            content
                //.roundedRectangleGlass(cornerRadius: 32, material: .ultraThin)
            BlurScrollView {
                content
            }
        }
    }
}

struct BlurScrollView<Content: View>: View {
    let content: Content
    
    @State private var scrollViewSize: CGSize = .zero
    @State private var scrollPosition: CGPoint = .zero
    let coordinateSpaceName = "scroll"
    
    @State private var heightOffset: Double = 0
    
    private var topBlurOffset: Double {
        let baseOffset = min(-(scrollPosition.y + 128.0), -64.0)
        return baseOffset
    }
    
    private var scrollPositionBottomOffset: Double {
        heightOffset - scrollPosition.y
    }
    
    private var bottomBlurOffset: Double {
        let baseOffset = max(scrollPositionBottomOffset + 128.0, 64)
        return baseOffset
    }
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ScrollView(.vertical) {
                    content
                        .getSize { scrollViewSize = $0 }
                        .getScrollOffset(coordinateSpaceName: coordinateSpaceName) {
                            scrollPosition = $0
                        }
                        .animation(nil, value: scrollViewSize.height)
                        
                }
                .scrollDisabled(scrollViewSize.height <= proxy.size.height)
                .scrollIndicators(.hidden)
                .scrollClipDisabled()
                .coordinateSpace(name: coordinateSpaceName)
                if scrollViewSize.height > proxy.size.height {
                    VStack {
                        VariableBlurView(maxBlurRadius: 8)
                        .frame(height: 128)
                        .offset(y: topBlurOffset)
                        Spacer()
                       
                        VariableBlurView(maxBlurRadius: 8, direction: .blurredBottomClearTop)
                        .frame(height: 128)
                        .offset(y: bottomBlurOffset)
                    }
                    .allowsHitTesting(false)
                    .transition(.opacity)
                }
            }
            .onAppear {
                heightOffset = proxy.size.height - scrollViewSize.height
            }
            .onChange(of: proxy.size.height) { _, newValue in
                heightOffset = newValue - scrollViewSize.height
            }
            .frame(height: scrollViewSize.height <= proxy.size.height ? scrollViewSize.height : .none )
            .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
            
        }
        .transition(.opacity)
        
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct SizeModifier: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: SizePreferenceKey.self, value: geometry.size)
        }
    }

    func body(content: Content) -> some View {
        content.overlay(sizeView)
    }
}

extension View {
    func getSize(perform: @escaping (CGSize) -> ()) -> some View {
        self
            .modifier(SizeModifier())
            .onPreferenceChange(SizePreferenceKey.self) {
                perform($0)
            }
    }
}

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}

struct ScrollModifier: ViewModifier {
    let coordinateSpaceName: String
    
    private var scrollView: some View {
        GeometryReader { geo in
            Color.clear.preference(key: ScrollOffsetPreferenceKey.self,
                                     value: geo.frame(in: .named(coordinateSpaceName)).origin)
        }
    }

    func body(content: Content) -> some View {
        content.background(scrollView)
    }
}

extension View {
    func getScrollOffset(coordinateSpaceName: String, perform: @escaping (CGPoint) -> ()) -> some View {
        self
            .modifier(ScrollModifier(coordinateSpaceName: coordinateSpaceName))
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) {
                perform($0)
            }
    }
}

import UIKit
import CoreImage.CIFilterBuiltins
import QuartzCore


public enum VariableBlurDirection {
    case blurredTopClearBottom
    case blurredBottomClearTop
}


public struct VariableBlurView: UIViewRepresentable {
    
    public var maxBlurRadius: CGFloat = 20
    
    public var direction: VariableBlurDirection = .blurredTopClearBottom
    
    /// By default, variable blur starts from 0 blur radius and linearly increases to `maxBlurRadius`. Setting `startOffset` to a small negative coefficient (e.g. -0.1) will start blur from larger radius value which might look better in some cases.
    public var startOffset: CGFloat = 0
    
    public func makeUIView(context: Context) -> VariableBlurUIView {
        VariableBlurUIView(maxBlurRadius: maxBlurRadius, direction: direction, startOffset: startOffset)
    }

    public func updateUIView(_ uiView: VariableBlurUIView, context: Context) {

    }
}

open class VariableBlurUIView: UIVisualEffectView {
    
    public init(maxBlurRadius: CGFloat = 20, direction: VariableBlurDirection = .blurredTopClearBottom, startOffset: CGFloat = 0) {
        
        super.init(effect: UIBlurEffect(style: .regular))

        // `CAFilter` is a private QuartzCore class that we dynamically declare in `CAFilter.h`.
        //             let variableBlur = CAFilter.filter(withType: "variableBlur") as! NSObject

        // Same but no need for `CAFilter.h`.
        
        let filterWithTypeSelector = Selector(("filterWithType:"))
        
        guard let CAFilter = NSClassFromString("CAFilter") as AnyObject as? NSObjectProtocol else {
                    print("[VariableBlurView] couldn't create CAFilter class.")
                    return
                }
        
        guard CAFilter.responds(to: filterWithTypeSelector) else {
                   print("[VariableBlurView] Doesn't respond to selector \(filterWithTypeSelector)")
                   return
               }
        
        let variableBlur = CAFilter
                   .perform(filterWithTypeSelector, with: "variableBlur")
                   .takeUnretainedValue()

        
        // The blur radius at each pixel depends on the alpha value of the corresponding pixel in the gradient mask.
        // An alpha of 1 results in the max blur radius, while an alpha of 0 is completely unblurred.
        let gradientImage = makeGradientImage(startOffset: startOffset, direction: direction)

        variableBlur.setValue(maxBlurRadius, forKey: "inputRadius")
        variableBlur.setValue(gradientImage, forKey: "inputMaskImage")
        variableBlur.setValue(true, forKey: "inputNormalizeEdges")

        // We use a `UIVisualEffectView` here purely to get access to its `CABackdropLayer`,
        // which is able to apply various, real-time CAFilters onto the views underneath.
        let backdropLayer = subviews.first?.layer

        // Replace the standard filters (i.e. `gaussianBlur`, `colorSaturate`, etc.) with only the variableBlur.
        backdropLayer?.filters = [variableBlur]
        
        // Get rid of the visual effect view's dimming/tint view, so we don't see a hard line.
        for subview in subviews.dropFirst() {
            subview.alpha = 0
        }
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func didMoveToWindow() {
        // fixes visible pixelization at unblurred edge (https://github.com/nikstar/VariableBlur/issues/1)
        guard let window, let backdropLayer = subviews.first?.layer else { return }
        backdropLayer.setValue(window.screen.scale, forKey: "scale")
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // `super.traitCollectionDidChange(previousTraitCollection)` crashes the app
    }
    
    private func makeGradientImage(width: CGFloat = 100, height: CGFloat = 100, startOffset: CGFloat, direction: VariableBlurDirection) -> CGImage { // much lower resolution might be acceptable
        let ciGradientFilter =  CIFilter.linearGradient()
//        let ciGradientFilter =  CIFilter.smoothLinearGradient()
        ciGradientFilter.color0 = CIColor.black
        ciGradientFilter.color1 = CIColor.clear
        ciGradientFilter.point0 = CGPoint(x: 0, y: height)
        ciGradientFilter.point1 = CGPoint(x: 0, y: startOffset * height) // small negative value looks better with vertical lines
        if case .blurredBottomClearTop = direction {
            ciGradientFilter.point0.y = 0
            ciGradientFilter.point1.y = height - ciGradientFilter.point1.y
        }
        return CIContext().createCGImage(ciGradientFilter.outputImage!, from: CGRect(x: 0, y: 0, width: width, height: height))!
    }
}
