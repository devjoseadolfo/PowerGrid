import SwiftUI

public struct CapsuleButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(
                LinearGradient(colors: configuration.isPressed
                               ? [.init(white: 0.6), .init(white: 0.8)]
                               : [.white, .init(white: 0.8)],
                                            startPoint: .top,
                                            endPoint: .bottom))
            .padding(6)
            .padding(.horizontal, 4)
            .background(Color.init(white: configuration.isPressed ? 0.2: 0.3))
            .scaleEffect(configuration.isPressed ? 1.1: 1.0)
            .overlay(content: {
                Capsule()
                    .offset(x: configuration.isPressed ? -8 : 8,
                            y: configuration.isPressed ? 8 : -8)
                    .foregroundStyle(Color.init(white: 1.0))
                    .opacity(configuration.isPressed ? 1.0 : 0.9)
                    .blur(radius: configuration.isPressed ? 4 : 8)
                    .blendMode(.softLight)
            })
            .overlay{
                Capsule()
                    .stroke(
                        LinearGradient(colors: [.white, .init(white: 0.5)],
                                       startPoint: .top,
                                       endPoint: .bottom),
                        lineWidth: 1.5)
                    .foregroundStyle(.clear)
                    .blur(radius: 0.75)
                    .opacity(1.0)
            }
            .clipShape(Capsule())
            .shadow(radius: configuration.isPressed ? 0 : 4,
                    x: configuration.isPressed ? 0 : -2,
                    y: configuration.isPressed ? 0 : 2)
    }
}

