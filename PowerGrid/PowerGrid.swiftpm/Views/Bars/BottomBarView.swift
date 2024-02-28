import SwiftUI

struct BottomBarView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var body: some View {
        HStack(alignment: .center,spacing: 20) {
            hearts
            production
            weather
        }
        .padding(.bottom, 16)
        .overlay {
            InsufficientProductionNotificationView()
                .frame(width: 240)
        }
    }
    
    var hearts: some View {
        HStack(spacing: 4) {
            ForEach(1...5, id: \.self) { i in
                Image(systemName: grid.hearts >= i ? "heart.fill" : "heart.slash")
                    .font(.system(size: 13))
                    .foregroundColor(grid.hearts >= i ? .init(red: 0.85, green: 0.1, blue: 0.1) : .black.opacity(0.5))
                    .contentTransition(.symbolEffect(.replace))
            }
        }
        .phaseAnimator([false, true], trigger: grid.hearts) { content, phase in
            content.scaleEffect(phase ? 1.2 : 1)
        } animation: { _ in
                .bouncy
        }
        .frame(width: 108)
        .padding(10)
        .padding(.vertical, 2)
        .capsuleGlass(shadowRadius: 8)
        .overlay {
            if grid.tutorialLevel == 4 {
                Tutorial4View()
                    .offset(y: -90)
            }
        }
    }
    
    var production: some View {
        HStack{
            HStack {
                Text(Image(systemName: "bolt"))
                    .barTextStyle()
                Spacer()
                Text(grid.currentTotalProduction.makeString() + " MW")
                    .barTextStyle()
                    .contentTransition(.numericText())
                    .animation(.linear, value: grid.currentTotalProduction)
                
            }
            .frame(width: 72)
            .padding(.horizontal, 4)
            DarkDivider()
            HStack {
                Text(Image(systemName: "powercord"))
                    .barTextStyle()
                Spacer()
                Text((grid.currentTotalConsumption + grid.batteryConsumption.amount) .makeString() + " MW")
                    .barTextStyle()
                    .contentTransition(.numericText())
                    .animation(.linear, value: grid.currentTotalConsumption + grid.batteryConsumption.amount)
            }
            .frame(width: 72)
            .padding(.horizontal, 4)
        }
        .padding(10)
        .capsuleGlass(shadowRadius: 8)
    }
    
    var weather: some View {
        HStack{
            HStack {
                Text(Image(systemName: "sun.max"))
                    .barTextStyle()
                Spacer()
                Text("\(grid.currentSunlightData.amount)%")
                    .barTextStyle()
                    .contentTransition(.numericText())
                .animation(.linear, value: grid.currentSunlightData.amount)
            }
            .frame(width: 56)
            .padding(.horizontal, 4)
            DarkDivider()
            HStack {
                Text(Image(systemName: "wind"))
                    .barTextStyle()
                Spacer()
                Text("\(grid.currentWindData.amount)%")
                    .barTextStyle()
                    .contentTransition(.numericText())
                    .animation(.linear, value: grid.currentWindData.amount)
            }
            .frame(width: 56)
            .padding(.horizontal, 4)
        }
        .padding(10)
        .capsuleGlass(shadowRadius: 8)
    }
}
