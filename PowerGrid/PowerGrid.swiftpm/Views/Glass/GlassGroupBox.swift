import SwiftUI

public struct GlassGroupBox<Content: View>: View {
    @Environment(ElectricGrid.self) private var grid
    
    let title: String
    let symbolName: String
    let content: Content

    @State private var showContent: Bool = true
    
    public init(title: String,
                symbolName: String,
                @ViewBuilder _ content: () -> Content) {
        self.title = title
        self.symbolName = symbolName
        self.content = content()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center) {
                Label(title, systemImage: symbolName)
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                Button {
                    withAnimation {
                        showContent.toggle()
                    }
                } label: {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 16, weight: .bold))
                        .offset(y: 1)
                        .rotationEffect(.degrees(showContent ? 180 : 0))
                }
                .buttonStyle(CircleButtonStyle(color: .gray))
            }
            .padding([.horizontal, .top], 16)
            .padding(.bottom, showContent ? 0 : 16)
            
            if showContent {
                content
                    .padding(4)
                    .transition(.opacity.combined(with: .identity))
                    .background(Color.black.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(8)
            }
        }
        .animation(.default, value: showContent)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .roundedRectangleGlass(cornerRadius: 16, material: .thin)
    }
}

