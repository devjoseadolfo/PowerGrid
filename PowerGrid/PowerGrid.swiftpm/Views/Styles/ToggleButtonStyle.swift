import SwiftUI

public struct ToggleButtonStyle: ButtonStyle {
    var isChosen: Bool
    var color: Color
    var lightColor: Color
    var darkColor: Color
    
    
    public init(color: Color, isChosen: Bool) {
        self.color = color
        self.lightColor = color.adjust(by: 0.3)
        self.darkColor = color.adjust(by: -0.3)
        self.isChosen = isChosen
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
             .frame(width: 36, height: 36, alignment: .center)
            .foregroundColor(.white)
            .background(
                Circle()
                    .fill(isChosen ? lightColor : Color.clear)
                    .offset(x: 12, y: -12)
                    .blur(radius: 12)
                
            )
            .background(isChosen ? darkColor : Color(white: 0.7))
            .clipShape(Circle())
            .shadow(color: isChosen ? color.opacity(0.6) : .clear,
                    radius: isChosen ? 8 : 0,
                    x: isChosen ? 4 : 0,
                    y: isChosen ? -4 : 0)
            .shadow(color: .black.opacity(isChosen ? 0.375 : 0),
                    radius: isChosen ? 8 : 0,
                    x: isChosen ? -4 : 0,
                    y: isChosen ? 4: 0)
            .animation(.easeIn, value: isChosen)
            
    }
}
