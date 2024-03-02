import SwiftUI

struct CellPopoverView: View {
    @Environment(ElectricGrid.self) private var grid
    var cell: GridCell
    @Binding var showPopover: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            if let component = cell.component {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(component.name)
                            .titleTextStyle()
                        Text(component is (any PowerPlant) ? "POWER PLANT" : "CUSTOMER")
                            .captionTextStyle()
                    }
                    Spacer()
                    if component is (any PowerPlant) {
                        Button {
                            component.active.toggle()
                        } label: {
                            Label("Active", systemImage: component.active ? "play.fill" : "pause.fill")
                                .labelStyle(.iconOnly)
                                .imageScale(.large)
                                .font(.system(size: 16, weight: .bold))
                                .symbolEffect(.bounce, value: component.active)
                                .frame(width: 24, height: 24)
                        }
                        .buttonStyle(CircleButtonStyle(color: component.active ? .green : .gray))
                    }
                }.padding([.horizontal, .top], 16)
                
                VStack(spacing: 16) {
                    Group {
                        switch component {
                        case let windTurbine as WindTurbine:
                            ComponentInfoView(component: windTurbine)
                                .environment(grid)
                        case let solarFarm as SolarFarm:
                            ComponentInfoView(component: solarFarm)
                                .environment(grid)
                        case let naturalGas as NaturalGas:
                            ComponentInfoView(component: naturalGas)
                                .environment(grid)
                        case let hydroelectric as Hydroelectric:
                            ComponentInfoView(component: hydroelectric)
                                .environment(grid)
                        case let residential as Residential:
                            ComponentInfoView(component: residential)
                                .environment(grid)
                        case let commercial as Commercial:
                            ComponentInfoView(component: commercial)
                                .environment(grid)
                        case let industrial as Industrial:
                            ComponentInfoView(component: industrial)
                                .environment(grid)
                        case let batteryStorage as BatteryStorage:
                            ComponentInfoView(component: batteryStorage)
                                .environment(grid)
                        default:
                            EmptyView()
                        }
                        if let customer = component as? (any Customer) {
                            CustomerDemandChartView(customer: customer)
                                .padding(.top, 4)
                                .tint(customer is Industrial ? .init(red: 0.5, green: 0.2, blue: 0.2) : (customer is Commercial ? .init(red: 0.7, green: 0.2, blue: 0.2) : .init(red: 0.9, green: 0.2, blue: 0.2)))
                                .padding([.top], -8)
                        }
                    }
                    Button {
                        showPopover = false
                        grid.cellToDelete = cell
                    } label: {
                        Text("Delete")
                            .buttonTextStyle()
                    }
                    .buttonStyle(RoundedRectangleButtonStyle(color: .red))
                    .padding([.horizontal, .bottom], 16)
                }
               
                
            } else {
                ComponentPurchaseView(cell: cell)
                    .environment(grid)
            }
        }
        .foregroundColor(.white)
        .transition(.opacity)
        .id(cell.id)
        .disabled(grid.tutorial)
    }
}
