import SwiftUI

struct RoundedRectangleGlassView: ViewModifier {
    let cornerRadius: CGFloat
    let material: Material
    
    @Binding var isPressed: Bool
    
    init(cornerRadius: CGFloat,
         material: Material,
         isPressed: Binding<Bool> = .constant(false)) {
        self.cornerRadius = cornerRadius
        self.material = material
        self._isPressed = isPressed
    }
    
    func body(content: Content) -> some View {
        return content
            .background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundStyle(material)
                    .blur(radius: 0.01)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(
                        LinearGradient(colors: [.white.opacity(0.1), .white.opacity(0.3)],
                                       startPoint: .top,
                                       endPoint: .bottom))
                    .blur(radius: 4)
                RoundedRectangle(cornerRadius: cornerRadius * 0.95)
                    .stroke(
                        LinearGradient(colors: [.init(white: 1),
                            .init(white: 0.85)],
                                       startPoint: .top,
                                       endPoint: .bottom),
                        lineWidth: 1.6)
                    .blur(radius: 1)
                    .scaleEffect(1.001)
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(radius: isPressed ? 0: cornerRadius, 
                    x: isPressed ? 0 : -cornerRadius/2, 
                    y: isPressed ? 0 : cornerRadius/2)
         .environment(\.colorScheme, .dark)
         .animation(.easeIn, value: isPressed)
    }
}
