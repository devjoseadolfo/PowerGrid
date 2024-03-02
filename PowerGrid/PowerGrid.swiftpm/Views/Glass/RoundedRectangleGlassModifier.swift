import SwiftUI

struct RoundedRectangleGlassModifier: ViewModifier {
    let cornerRadius: CGFloat
    let material: Material
    let colorScheme: ColorScheme
    
    init(cornerRadius: CGFloat,
         material: Material,
         colorScheme: ColorScheme = .dark) {
        self.cornerRadius = cornerRadius
        self.material = material
        self.colorScheme = colorScheme
    }
    
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(material)
                    .blur(radius: 0.01)
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(LinearGradient(colors: [.white.opacity(0.05), .white.opacity(0.25)],
                                       startPoint: .top,
                                       endPoint: .bottom))
                        .blur(radius: 4)
                    }
            }
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.clear)
                    .stroke(
                        LinearGradient(colors: [.init(white: 0.9), 
                            .init(white: 0.75)],
                                       startPoint: .top,
                                       endPoint: .bottom),
                        lineWidth: 2)
                    .blur(radius: 1)
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: .black.opacity(0.25),
                    radius:  cornerRadius/2,
                    x: -cornerRadius/2,
                    y: cornerRadius/2)
            .environment(\.colorScheme, colorScheme)
    }
}
