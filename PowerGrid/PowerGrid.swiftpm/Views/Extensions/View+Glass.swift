import SwiftUI

extension View {
    public func roundedRectangleGlass(cornerRadius: CGFloat,
                                      material: Material = .ultraThinMaterial,
                                      colorScheme: ColorScheme = .dark) -> some View {
        return modifier(RoundedRectangleGlassView(cornerRadius: cornerRadius,
                                                  material: material,
                                                  colorScheme: colorScheme))
    }
    
    public func capsuleGlass(shadowRadius: Double = 16) -> some View {
        return modifier(CapsuleGlassView(shadowRadius: shadowRadius))
    }
    public func miniCapsuleGlass(shadowRadius: Double = 8) -> some View {
        return modifier(MiniCapsuleGlassView(shadowRadius: shadowRadius))
    }
}


