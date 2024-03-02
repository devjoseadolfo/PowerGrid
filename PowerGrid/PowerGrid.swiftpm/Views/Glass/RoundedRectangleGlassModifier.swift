import SwiftUI

struct GlassShape<S: InsettableShape>: View {
    let shape: S
    let material: Material
    
    var body: some View {
        shape
            .fill(material)
            .blur(radius: 0.01)
            .overlay {
                LinearGradient(colors: [.white.opacity(0.05), .white.opacity(0.25)],
                               startPoint: .top,
                               endPoint: .bottom)
                .blur(radius: 0.05)
            }
    }
}

extension InsettableShape {
    func glass(material: Material) -> some View {
        return GlassShape(shape: self, material: material)
    }
}

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
                    .glass(material: material)
            }
        
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.clear)
                    .stroke(
                        LinearGradient(colors: [.init(white: 0.9), 
                            .init(white: 0.75)],
                                       startPoint: .top,
                                       endPoint: .bottom)
                        .opacity(0.9),
                        lineWidth: 1)
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
