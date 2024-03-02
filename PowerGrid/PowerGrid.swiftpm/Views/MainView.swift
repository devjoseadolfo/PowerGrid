import SwiftUI

struct MainView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var body: some View {
        ViewThatFits {
            HStack(spacing: 8) {
                LeftSideBarView(selectionEnable: false)
                    .frame(width: 384, alignment: .leading)
                    .zIndex(grid.tutorialLevel == 3 || grid.tutorialLevel == 10 || grid.tutorialLevel == 11 ? 10 : 0)
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
                    .frame(minWidth: 384, maxWidth: 360, alignment: .trailing)
            }
            HStack(spacing: 0) {
                LeftSideBarView(selectionEnable: true)
                    .frame(minWidth: 384, maxWidth: 360, alignment: .leading)
                    .zIndex(grid.tutorialLevel == 3 || grid.tutorialLevel == 10 || grid.tutorialLevel == 11 ? 10 : 0)
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
