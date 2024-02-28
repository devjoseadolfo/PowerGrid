import SwiftUI

struct MainView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var body: some View {
        ZStack {
            BackgroundView()
           
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
        .animation(.easeIn, value: grid.currentSunlightData.weather)
    }
}
