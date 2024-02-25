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
            HStack {
                Label(title, systemImage: symbolName)
                    .font(.system(size: 18, weight: .bold))
                Spacer()
            }
            content
        }
        .padding(16)
        .roundedRectangleGlass(cornerRadius: 16, material: .ultraThin)
    }
}

