import SwiftUI

struct CellBackgroundView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var objectBrightness: Double {
        switch grid.currentHour {
        case 6, 18:
            return grid.currentSunlightData.weather == .sunny ? -0.1 : -0.2
        case 7...17:
            return grid.currentSunlightData.weather == .sunny ? 0 : -0.1
        default:
            return -0.2
        }
    }
    
    var backgroundBrightness: Double {
        switch grid.currentHour {
        case 6, 18:
            return grid.currentSunlightData.weather == .sunny ? -0.1 : -0.2
        case 7...17:
            return grid.currentSunlightData.weather == .sunny ? 0 : -0.1
        default:
            return 0
        }
    }
    
    var imageBackground: String {
        switch grid.currentHour {
        case 6, 18:
            return "transition"
        case 7...17:
            return "day"
        default:
            return "night"
        }
    }
    
    var moonAngle: Double {
        switch grid.currentHour {
        case 17...23:
            return 17.5 * Double(grid.currentHour-24)
        case 0...6:
            return 17.5 * Double(grid.currentHour)
        default:
            return 0
        }
    }
    
    var body: some View {
        ZStack {
            Image(imageBackground)
                .resizable()
                .brightness(backgroundBrightness)
            Image("sun")
                .resizable()
                .rotationEffect(.degrees(16 * Double(grid.currentHour - 12)))
                .opacity((6...18).contains(grid.currentHour) ? 1 : 0)
            Image("moon")
                .resizable()
                .rotationEffect(.degrees(moonAngle))
                .opacity(!(6...18).contains(grid.currentHour) ? 1 : 0)
            Image("clouds")
                .resizable()
                .transition(.opacity)
                .opacity(grid.currentSunlightData.weather == .lightRains || grid.currentSunlightData.weather == .heavyRains || grid.currentSunlightData.weather == .cloudy ? 1 : 0)
            Image("land")
                .resizable()
                .brightness(objectBrightness)
        }
        .grayscale(grid.currentSunlightData.weather == .lightRains || grid.currentSunlightData.weather == .heavyRains || grid.currentSunlightData.weather == .cloudy ? 0.6 : 0)
        .frame(width: 100, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .animation(.easeIn, value: grid.currentSunlightData.weather)
    }
}

