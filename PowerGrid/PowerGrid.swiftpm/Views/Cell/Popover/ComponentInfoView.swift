import SwiftUI

struct ComponentInfoView<C: Component>: View {
    @Environment(ElectricGrid.self) private var grid
    @ObservedObject var component: C
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(component.name)
                        .font(.system(size: 18,
                                      weight: .bold))
                    if component is (any PowerPlant) {
                        Text("POWER PLANT")
                            .font(.system(size: 12,
                                          weight: .regular,
                                          design: .monospaced))
                            .opacity(0.75)
                    } else if component is (any Customer) {
                        Text("CUSTOMER")
                            .font(.system(size: 12,
                                          weight: .regular,
                                          design: .monospaced))
                            .opacity(0.75)
                    }
                }
                Spacer()
                if component is (any PowerPlant) {
                    Button {
                        component.active.toggle()
                    } label: {
                        Label("Active", systemImage: component.active ? "play" : "pause")
                            .labelStyle(.iconOnly)
                            .imageScale(.large)
                            .font(.system(size: 16, weight: .regular))
                            .symbolEffect(.bounce, value: component.active)
                    }
                    .buttonStyle(ToggleButtonStyle(color: .green, isChosen: component.active))
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                if let powerPlant = component as? (any PowerPlant) {
                    ComponentInfoBodyView(title: "Running Cost:",
                                          titleValue: "$" + String(powerPlant.runningCost))
                    ComponentInfoBodyView(title: "Production:",
                                          titleValue: String(powerPlant.production) + " MW",
                                          subtitle: "Max Production:",
                                          subtitleValue: String(powerPlant.maxProduction) + " MW",
                                          currentValue: Double(powerPlant.production),
                                          totalValue: Double(powerPlant.maxProduction))
                    .tint(.orange)
                }
                if let customer = component as? (any Customer) {
                    ComponentInfoBodyView(title: "Last Payment:",
                                          titleValue: "$" + String(customer.lastPayment))
                    ComponentInfoBodyView(title: "Consumption:",
                                          titleValue: String(customer.demand) + " MW",
                                          subtitle: "Max Consumption:",
                                          subtitleValue: String(customer.maxDemand) + " MW",
                                          currentValue: Double(customer.demand),
                                          totalValue: Double(customer.maxDemand))
                    .tint(Color.init(.sRGB,
                                     red: 0.9,
                                     green: 0.2,
                                     blue: 0.2,
                                     opacity: 1.0))
                    CustomerDemandChartView(customer: customer)
                        .padding(8)
                        .padding([.top, .trailing], 4)
                        .roundedRectangleGlass(cornerRadius: 8, material: .thinMaterial)
                        .padding(.top, 4)
                        .tint(customer is Industrial ? .init(red: 0.5, green: 0.2, blue: 0.2) : (customer is Commercial ? .init(red: 0.7, green: 0.2, blue: 0.2) : .init(red: 0.9, green: 0.2, blue: 0.2)))
                }
                if let hydroelectric = component as? Hydroelectric {
                    ComponentInfoBodyView(title: "Reservoir Level:",
                                          titleValue: String(hydroelectric.reservoirLevel/10) + "%",
                                          currentValue: Double(hydroelectric.reservoirLevel),
                                          totalValue: 1000)
                    .tint(Color.init(.sRGB,
                                     red: 0.15,
                                     green: 0.25,
                                     blue: 0.95))
                }
                if let naturalGas = component as? NaturalGas {
                    ComponentInfoBodyView(title: "Fuel Level:",
                                          titleValue: String(naturalGas.fuelLevel/10) + "%",
                                          currentValue: Double(naturalGas.fuelLevel),
                                          totalValue: 1000)
                    .tint(Color.init(.sRGB,
                                     red: 0.65, green: 0.1, blue: 0.9))
                    .animation(.easeIn, value: naturalGas.fuelLevel)
                    FuelPurchaseView(naturalGas: naturalGas)
                }
                if let battery = component as? BatteryStorage {
                    ComponentInfoBodyView(title: "Consumption:",
                                          titleValue: String(battery.stored) + " MW",
                                          subtitle: "Max Consumption:",
                                          subtitleValue: "10 MW",
                                          currentValue: Double(battery.stored),
                                          totalValue: Double(20))
                    .tint(.red)
                    ComponentInfoBodyView(title: "Battery Level:",
                                          titleValue: String(battery.storage) + " MW",
                                          currentValue: Double(battery.storage),
                                          totalValue:  Double(battery.maxStorage))
                    .tint(.green)
                    .animation(.easeIn, value: battery.storage)
                }
                if component is WindTurbine {
                    ComponentInfoBodyView(title: "Wind Level:",
                                          titleValue: String(grid.currentWindData.amount) + "%",
                                          currentValue: Double(grid.currentWindData.amount),
                                          totalValue: 100)
                    .tint(.cyan)
                }
                if component is SolarFarm {
                    ComponentInfoBodyView(title: "Sunlight Level:",
                                          titleValue: String(grid.currentSunlightData.amount) + "%",
                                          currentValue: Double(grid.currentSunlightData.amount),
                                          totalValue: 100)
                    .tint(.yellow)
                }
                if let powerPlant = component as? (any PowerPlant) {
                    ComponentInfoBodyView(title: "Maintenance Level:",
                                          titleValue: String(powerPlant.maintenance/10) + "%",
                                          currentValue: Double(powerPlant.maintenance),
                                          totalValue: 1000)
                    .tint(.init(white: 0.2))
                }
            }
        }
    }
}
