import SwiftUI

struct TopBarView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            newGame
            date
            money
        }
        .padding(.top, 16)
    }
    
    var newGame: some View {
        HStack{
            Button {
                grid.newGame = true
            } label: {
                HStack {
                    Text(Image(systemName: "gamecontroller"))
                        .barTextStyle()
                    Spacer()
                    Text("NEW GAME")
                        .barTextStyle()
                }
                .padding(2)
                
            }
            .buttonStyle(CapsuleButtonStyle())
            .frame(width: 112)
        }
        .padding(6)
        .capsuleGlass(shadowRadius: 8)
    }
    
    var date: some View {
        HStack {
            HStack {
                Text(Image(systemName: "calendar"))
                    .barTextStyle()
                Spacer()
                Text(grid.date
                    .makeDateString()
                    .uppercased())
                .barTextStyle()
                .contentTransition(.numericText())
            }
            .frame(width: 70)
            .padding(.horizontal, 4)
            DarkDivider()
            HStack {
                Text(Image(systemName: "clock"))
                    .barTextStyle()
                Spacer()
                Text(grid.date
                    .makeTimeString()
                    .uppercased())
                .font(.system(size: 12, design: .monospaced))
                .contentTransition(.numericText())
            }
            .frame(width: 60)
            .padding(.horizontal, 4)
            Button {
                if grid.money >= grid.calculateTotalRunningCost() {
                    grid.addHour()
                } else {
                    grid.sufficientFundsError = true
                }
            } label: {
                HStack {
                    Text(Image(systemName: "hourglass.badge.plus"))
                        .barTextStyle()
                    Spacer()
                    Text("+1HR".uppercased())
                        .barTextStyle()
                }
            }
            .buttonStyle(CapsuleButtonStyle())
            .frame(width: 72)
        }
        .animation(.linear, value: grid.date)
        .padding(6)
        .capsuleGlass(shadowRadius: 8)
    }
    
    var money: some View {
        HStack {
            Text(Image(systemName: "dollarsign"))
                .font(.system(size: 12))
            Spacer()
            Text(grid.money.makeString())
                .font(.system(size: 12, design: .monospaced))
                .contentTransition(.numericText())
                .animation(.linear, value: grid.money)
        }
        .frame(width: 100)
        .padding(10)
        .padding(.horizontal, 4)
        .capsuleGlass(shadowRadius: 8)
    }
}
