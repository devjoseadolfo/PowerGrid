import SwiftUI

public struct CircleButtonStyle: ButtonStyle {
    var color: Color
    var lightColor: Color
    var darkColor: Color
    
    
    public init(color: Color) {
        self.color = color
        self.lightColor = color.adjust(by: 0.25)
        self.darkColor = color.adjust(by: -0.25)
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .aspectRatio(1.0, contentMode: .fit)
            .padding(8)
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
                Circle()
                    .offset(x: configuration.isPressed ? -4 : 8,
                            y: configuration.isPressed ? 4 : -8)
                    .foregroundStyle(configuration.isPressed ?
                                     lightColor.adjust(by: -0.15)
                                     : lightColor)
                    .opacity(configuration.isPressed ? 1 : 0.9)
                    .blur(radius: configuration.isPressed ? 8 : 8)
                    .blendMode(.softLight)
            })
            .overlay{
                Circle()
                    .stroke(
                        LinearGradient(colors: [.white, .init(white: 0.5)],
                                       startPoint: .top,
                                       endPoint: .bottom),
                        lineWidth: 1.5)
                    .foregroundStyle(.clear)
                    .blur(radius: 0.75)
                    .opacity(1.0)
            }
            .clipShape(Circle())
            .shadow(radius: configuration.isPressed ? 0 : 8,
                    x: configuration.isPressed ? 0 : -4,
                    y: configuration.isPressed ? 0 : 4)
            
    }
}
