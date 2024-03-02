import SwiftUI

struct MainView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var body: some View {
        ViewThatFits {
            HStack(spacing: 8) {
                LeftSideBarView(selectionEnable: false)
                    .frame(width: 360)
                ZStack {
                    GridView()
                        .frame(maxHeight: .infinity)
                    TopBarView()
                        .frame(maxHeight: .infinity, alignment: .top)
                    BottomBarView()
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
                .frame(minWidth: 200, maxWidth: .infinity, maxHeight: .infinity)
                RightSideBarView()
                    .frame(width: 360)
            }
            HStack(spacing: 0) {
                LeftSideBarView(selectionEnable: true)
                    .frame(width: 360)
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
        .background(BackgroundView())
        .animation(.easeIn, value: grid.currentSunlightData.weather)
    }
}
