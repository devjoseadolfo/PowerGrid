import SwiftUI

public struct GlassGroupBox<Content: View>: View {
    let title: String
    let symbolName: String
    let content: Content

    public init(title: String,
                symbolName: String,
                @ViewBuilder _ content: () -> Content) {
        self.title = title
        self.symbolName = symbolName
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Label(title, systemImage: symbolName)
                .font(.system(size: 18, weight: .bold))
                .padding([.horizontal, .top], 8)
            content
        }
        .padding(8)
        .roundedRectangleGlass(cornerRadius: 16, material: .ultraThin)
    }
}

