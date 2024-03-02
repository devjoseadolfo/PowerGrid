import SwiftUI

struct CellGlanceView: View {
    @Environment(ElectricGrid.self) private var grid
    var component: any Component
    
    var body: some View {
        HStack{
            if let powerPlant = component as? (any PowerPlant) {
                if !(powerPlant is BatteryStorage) || (powerPlant is BatteryStorage && grid.batteryConsumption.amount == 0) {
                    CircularProgressView(color: .init(.sRGB,
                                                      red: 0.9,
                                                      green: 0.45,
                                                      blue: 0.4,
                                                      opacity: 1.0),
                                         symbol: "bolt.fill",
                                         currentValue: Double(powerPlant.production),
                                         maxValue: Double(powerPlant.maxProduction))
                    .animation(.easeIn, value: powerPlant.production)
                }
                if let naturalGas = powerPlant as? NaturalGas {
                    CircularProgressView(color: .init(.sRGB,
                                                      red: 0.65,
                                                      green: 0.3,
                                                      blue: 0.8,
                                                      opacity: 1.0),
                                         symbol: "fuelpump.fill",
                                         currentValue: Double(naturalGas.fuelLevel),
                                         maxValue: Double(naturalGas.maxFuelLevel))
                }
                if let hydroelectic = powerPlant as? Hydroelectric {
                    CircularProgressView(color: .init(.sRGB,
                                                      red: 0.25,
                                                      green: 0.35,
                                                      blue: 0.95),
                                         symbol: "drop.fill",
                                         currentValue: Double(hydroelectic.reservoirLevel),
                                         maxValue: 1000)
                }
                if let storage = powerPlant as? BatteryStorage {
                    if grid.batteryConsumption.amount > 0 {
                        CircularProgressView(color: .init(.sRGB,
                                                          red: 0.9,
                                                          green: 0.2,
                                                          blue: 0.2,
                                                          opacity: 1.0),
                                             symbol: "powerplug.fill",
                                             currentValue: Double(storage.stored),
                                             maxValue: 20)
                    }
                    CircularProgressView(color: .init(.sRGB,
                                                      red: 0.2,
                                                      green: 0.7,
                                                      blue: 0.2,
                                                      opacity: 1.0),
                                         symbol: "battery.100percent",
                                         currentValue: Double(storage.storage),
                                         maxValue: Double(storage.maxStorage))
                }
                CircularProgressView(color: .init(.sRGB,
                                                  red: 0.45,
                                                  green: 0.45,
                                                  blue: 0.45,
                                                  opacity: 1.0),
                                     symbol: "gearshape.fill",
                                     currentValue: Double(powerPlant.maintenance),
                                     maxValue: 1000)
            }
            
            if let customer = component as? (any Customer) {
                CircularProgressView(color: .init(.sRGB,
                                                  red: 0.9,
                                                  green: 0.2,
                                                  blue: 0.2,
                                                  opacity: 1.0),
                                     symbol: "powerplug.fill",
                                     currentValue: Double(customer.demand),
                                     maxValue: Double(customer.maxDemand))
            }
        }
        .opacity(component.active ? 1 : 0.5)
        .grayscale(component.active ? 0 : 0.8)
        .padding(6)
        .miniCapsuleGlass(shadowRadius: 4)
        .animation(.easeInOut, value: component.active)
    }
}

