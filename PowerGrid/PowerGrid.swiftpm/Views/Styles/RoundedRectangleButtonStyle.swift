import SwiftUI

public struct RoundedRectangleButtonStyle: ButtonStyle {
    var color: Color
    var lightColor: Color
    var darkColor: Color
    
    let cornerRadius: Double
    
    public init(color: Color, cornerRadius: Double = 8) {
        self.color = color
        self.lightColor = color.adjust(by: 0.25)
        self.darkColor = color.adjust(by: -0.25)
        self.cornerRadius = cornerRadius
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: 40)
            .foregroundStyle(
                LinearGradient(colors: configuration.isPressed
                               ? [.init(white: 0.6), .init(white: 0.8)]
                               : [.white, .init(white: 0.8)],
                                            startPoint: .top,
                                            endPoint: .bottom))
            .background(configuration.isPressed ?
                        darkColor.adjust(by: -0.15)
                        : darkColor)
            .overlay(content: {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .offset(x: configuration.isPressed ? -16 : 16,
                            y: configuration.isPressed ? 16 : -16)
                    .foregroundStyle(configuration.isPressed ?
                                     lightColor.adjust(by: -0.15)
                                     : lightColor)
                    .opacity(configuration.isPressed ? 1 : 0.9)
                    .blur(radius: configuration.isPressed ? 16 : 16)
                    .blendMode(.softLight)
            })
            .overlay{
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        LinearGradient(colors: [.white, .init(white: 0.5)],
                                       startPoint: .top,
                                       endPoint: .bottom),
                        lineWidth: 1.5)
                    .foregroundStyle(.clear)
                    .blur(radius: 0.75)
                    .opacity(1.0)
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(radius: configuration.isPressed ? 0 : 8,
                    x: configuration.isPressed ? 0 : -4,
                    y: configuration.isPressed ? 0 : 4)
    }
}


