import SwiftUI

struct BackgroundView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var backgroundTopColor: Color {
        switch grid.currentHour {
        case 6:
            return .sunriseTop
        case 18:
            return .sunsetTop
        case 7...17:
            return .sunnyTop
        default:
            return .midnightTop
        }
    }
    
    var backgroundBottomColor: Color {
        switch grid.currentHour {
        case 6:
            return .sunriseBottom
        case 18:
            return .sunsetBottom
        case 7...17:
            return .sunnyBottom
        default:
            return .midnightBottom
        }
    }
    
    
    var grayscaleAmount: Double {
        switch grid.currentSunlightData.weather {
        case .heavyRains:
            return 0.9
        case .cloudy, .lightRains:
            return 0.75
        default:
            return 0
        }
    }
    
    var brightnessAmount: Double {
        switch grid.currentSunlightData.weather {
        case .heavyRains:
            return -0.075
        case .cloudy, .lightRains:
            return -0.05
        default:
            switch grid.currentHour {
            case 19...23:
                return 0
            case 7...17:
                return Double(6 - abs(grid.currentHour - 12))  * 0.02
            default:
                return 0
            }
        }
    }
    
    var time: Double {
        Double(grid.currentHour) / 24
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
    
    @State private var warn: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [
               backgroundTopColor,
               backgroundBottomColor
            ], startPoint: .top, endPoint: .bottom)
            /*
            Image("moon")
                .resizable()
                .aspectRatio(2, contentMode: .fit)
                .border(.white)
                .rotationEffect(.degrees(moonAngle), 
                                anchor: .bottom)
                .opacity(!(6...18).contains(grid.currentHour) ? 1 : 0)
            Image("sun")
                .resizable()
                .aspectRatio(2, contentMode: .fit)
                .border(.white)
                .rotationEffect(.degrees(16 * Double(grid.currentHour - 12)),
                                anchor: .bottom)
                .opacity((6...18).contains(grid.currentHour) ? 1 : 0)
             */
            if (grid.currentSunlightData.weather == .heavyRains) {
                VortexView(.rain) {
                    Circle()
                        .fill(.white)
                        .frame(width: 32)
                        .tag("circle")
                }.transition(.opacity)
            }
            if (grid.currentSunlightData.weather == .lightRains) {
                VortexView(.lightRain) {
                    Circle()
                        .fill(.white)
                        .frame(width: 32)
                        .tag("circle")
                }
                .transition(.opacity)
            }
            Image("clouds")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .transition(.opacity)
                .opacity(grid.currentSunlightData.weather == .lightRains || grid.currentSunlightData.weather == .heavyRains || grid.currentSunlightData.weather == .cloudy ? 1 : 0)
        }
        .grayscale(grayscaleAmount)
        .brightness(brightnessAmount)
        .animation(.easeIn, value: time)
        .animation(.easeIn, value: grid.currentSunlightData.weather)
        .overlay (
            warn && grid.hearts < 5 ?  Color.red.opacity(0.9) : Color.clear
        )
        .animation(.easeIn, value: warn)
        .onChange(of: grid.hearts, { oldValue, newValue in
            warn = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                warn = false
            }
        })
       
    }
}

extension Color {
    static let midnightTop = Color(red: 0.05, green: 0.05, blue: 0.15)
    static let midnightBottom = Color(red: 0.15, green: 0.15, blue: 0.3)
    
    static let sunriseTop = Color(red: 0.2, green: 0.4, blue: 0.6)
    static let sunriseBottom = Color(red: 0.55, green: 0.3, blue: 0.45)
    
    static let sunnyTop = Color(red: 0.1, green: 0.3, blue: 0.65)
    static let sunnyBottom = Color(red: 0.2, green: 0.55, blue: 0.9)
    
    static let sunsetTop = Color.sunriseTop
    static let sunsetBottom =  Color(red: 0.7, green: 0.475, blue: 0.2)
}
