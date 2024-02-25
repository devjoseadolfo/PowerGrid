import SwiftUI

struct TopBarView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var body: some View {
        HStack(alignment: .center,spacing: 20) {
            HStack{
                Button {
                    grid.newGame = true
                } label: {
                    HStack {
                        Text(Image(systemName: "gamecontroller"))
                            .font(.system(size: 12))
                        Spacer()
                        Text("NEW GAME")
                            .font(.system(size: 12, design: .monospaced))
                    }
                    .padding(2)
                    
                }
                .buttonStyle(CapsuleButtonStyle())
                .frame(width: 112)
                .disabled(grid.tutorial)
            }
            .padding(6)
            .capsuleGlass(shadowRadius: 8)
            HStack{
                HStack {
                    Text(Image(systemName: "calendar"))
                        .font(.system(size: 12))
                    Spacer()
                    Text(grid.date
                        .makeDateString()
                        .uppercased())
                    .font(.system(size: 12, design: .monospaced))
                }
                .frame(width: 70)
                .padding(.horizontal, 4)
                Divider()
                    .frame(height: 16)
                HStack {
                    Text(Image(systemName: "clock"))
                        .font(.system(size: 12))
                    Spacer()
                    Text(grid.date
                        .makeTimeString()
                        .uppercased())
                    .font(.system(size: 12, design: .monospaced))
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
                            .font(.system(size: 12))
                        Spacer()
                        Text("+1HR".uppercased())
                            .font(.system(size: 12, design: .monospaced))
                    }
                }
                .buttonStyle(CapsuleButtonStyle())
                .frame(width: 72)
                .disabled(grid.tutorial)
            }
            .padding(6)
            .capsuleGlass(shadowRadius: 8)
            .overlay {
                if grid.tutorialLevel == 12 {
                    Tutorial12View()
                        .offset(x: 90, y: 115)
                }
            }
            HStack {
                Text(Image(systemName: "dollarsign"))
                    .font(.system(size: 12))
                Spacer()
                Text(grid.money.makeString())
                    .font(.system(size: 12, design: .monospaced))
            }
            .frame(width: 100)
            .padding(10)
            .padding(.horizontal, 4)
            .capsuleGlass(shadowRadius: 8)
            .overlay {
                if grid.tutorialLevel == 8 {
                    Tutorial8View()
                        .offset(y: 125)
                }
            }
        }
        .padding(.top, 16)
        
    }
}
