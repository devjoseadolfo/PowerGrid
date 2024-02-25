import SwiftUI

struct SideBarView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            PowerInfoView()
                .overlay {
                    if grid.tutorialLevel == 3 {
                        Tutorial3View()
                            .offset(x: 320, y: 20)
                    }
                }
            DemandInfoView()                .overlay {
                    if grid.tutorialLevel == 10 {
                        Tutorial10View()
                            .offset(x: 320, y: 20)
                    }
                }
            SunlightInfoView()
                .overlay {
                    if grid.tutorialLevel == 11 {
                        Tutorial11View()
                            .offset(x: 320, y: 110)
                    }
                }
            WindInfoView()
        }
        .padding(16)
        .zIndex(grid.tutorialLevel == 3 || grid.tutorialLevel == 10 || grid.tutorialLevel == 11 ? 10 : 0)
    }
}
