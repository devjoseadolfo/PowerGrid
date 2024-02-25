import SwiftUI

struct MainView: View {
    @Environment(ElectricGrid.self) private var grid
    @State private var warn: Bool = false
    
    private var backgroundColor: Color {
        switch grid.currentSunlightData.weather {
        case .night:
            return Color(white: 30/255)
        case .heavyRains:
            switch grid.currentHour {
            case 6, 18:
                return Color(white: 50/255)
            case 7...17:
                return Color(white: 80/255)
            default:
                return Color(white: 30/255)
            }
        case .lightRains:
            switch grid.currentHour {
            case 6, 18:
                return Color(white: 100/255)
            case 7...17:
                return Color(white: 130/255)
            default:
                return Color(white: 30/255)
            }
        case .cloudy:
            switch grid.currentHour {
            case 6, 18:
                return Color(white: 120/255)
            case 7...17:
                return Color(white: 160/255)
            default:
                return Color(white: 30/255)
            }
        default:
            switch grid.currentHour {
            case 6, 18:
                return Color(white: 180/255)
            case 7...17:
                return Color(white: 210/255)
            default:
                return Color(white: 30/255)
            }
        }
    }
    var body: some View {
        ZStack {
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
            HStack(spacing: 0) {
                SideBarView()
                    .frame(minWidth: 300, maxWidth: 360, alignment: .leading)
                ZStack {
                    GridView()
                        .frame(maxHeight: .infinity)
                    TopBarView()
                        .frame(maxHeight: .infinity, alignment: .top)
                    BottomBarView()
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
                .frame(minWidth: 200, maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onChange(of: grid.hearts, { oldValue, newValue in
            warn = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                warn = false
            }
        })
        .background(warn && grid.hearts < 5 ? Color.red : backgroundColor)
        .animation(.easeIn, value: warn)
        .animation(.easeIn, value: backgroundColor)
        .animation(.easeIn, value: grid.currentSunlightData.weather)
    }
}
