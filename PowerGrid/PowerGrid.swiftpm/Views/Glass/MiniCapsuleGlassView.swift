import SwiftUI

struct MiniCapsuleGlassView: ViewModifier {
    let shadowRadius: Double
    func body(content: Content) -> some View {
        return content
            .background {
                Capsule()
                    .foregroundStyle(.regularMaterial)
                Capsule()
                    .fill(
                        LinearGradient(colors: [.white.opacity(0.1), .white.opacity(0.3)],
                                       startPoint: .top,
                                       endPoint: .bottom))
                    .blur(radius: 4)
                Capsule()
                    .stroke(
                        LinearGradient(colors: [.white, .init(white: 0.85)],
                                       startPoint: .top,
                                       endPoint: .bottom),
                        lineWidth: 1.5)
                    .foregroundStyle(.clear)
                    .blur(radius: 0.75)
            }
            .clipShape(Capsule())
            .environment(\.colorScheme, .light)
            .shadow(color: .black.opacity(0.2), radius: shadowRadius, x: -shadowRadius/2, y: shadowRadius/2)
    }
}
