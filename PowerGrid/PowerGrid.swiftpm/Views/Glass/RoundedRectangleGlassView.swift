import SwiftUI

struct RoundedRectangleGlassView: ViewModifier {
    let cornerRadius: CGFloat
    let material: Material
    let colorScheme: ColorScheme
    
    @Binding var isPressed: Bool
    
    init(cornerRadius: CGFloat,
         material: Material,
         colorScheme: ColorScheme = .dark,
         isPressed: Binding<Bool> = .constant(false)) {
        self.cornerRadius = cornerRadius
        self.material = material
        self.colorScheme = colorScheme
        self._isPressed = isPressed
    }
    
    func body(content: Content) -> some View {
        return content
            .background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundStyle(material
                        .shadow(.inner(color: .black.opacity(0.5), radius: 3, y: 1))
                        .shadow(.inner(color: .white, radius: 1.5, y: 0.5)))
                    .blur(radius: 0.01)
                    .overlay {
                        LinearGradient(colors: [.white.opacity(0.05), .white.opacity(0.25)],
                                       startPoint: .top,
                                       endPoint: .bottom)
                    }
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(radius: isPressed ? 0: cornerRadius,
                    x: isPressed ? 0 : -cornerRadius/2, 
                    y: isPressed ? 0 : cornerRadius/2)
            .environment(\.colorScheme, colorScheme)
            .animation(.easeIn, value: isPressed)
    }
}
