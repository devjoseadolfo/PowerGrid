import SwiftUI

struct FuelPurchaseView: View {
    @Environment(ElectricGrid.self) private var grid
    @ObservedObject var naturalGas: NaturalGas
    
    var price20Percent: Int {
        naturalGas.getFuelPrice(fuelAmount: 200)
    }
    
    var priceFill: Int {
        
        naturalGas.getFuelPrice(fuelAmount: 1000 - naturalGas.fuelLevel)
    }
    
    var enable20Percent: Bool {
        naturalGas.fuelLevel <= 800 && grid.money >= price20Percent
    }
    
    var enableFill: Bool {
        naturalGas.fuelLevel < 1000 && grid.money >= priceFill
    }
    
    var body: some View {
        HStack {
            Button {
                grid.money -= price20Percent
                naturalGas.addFuelLevel(200)
            } label: {
                VStack{
                    Text("+20%")
                        .font(.system(size: 16, weight: .bold))
                    Text("$" + String(price20Percent))
                        .font(.system(size: 12, design: .monospaced))
                }
            }
            .buttonStyle(RoundedRectangleButtonStyle(color: .purple))
            .grayscale(enable20Percent ? 0 : 1)
            .opacity(enable20Percent ? 1 : 0.5)
            .disabled(!enable20Percent)
            
            Button {
                grid.money -= priceFill
                naturalGas.fuelLevel = 1000
            } label: {
                VStack{
                    Text("Fill")
                        .font(.system(size: 16, weight: .bold))
                    Text("$" + String(priceFill))
                        .font(.system(size: 12, design: .monospaced))
                }
                
            }
            .buttonStyle(RoundedRectangleButtonStyle(color: .purple))
            .grayscale(enableFill ? 0 : 1)
            .opacity(enableFill ? 1 : 0.5)
            .disabled(!enableFill)
        }
    }
}
