import SwiftUI

struct CellPopoverView: View {
    @Environment(ElectricGrid.self) private var grid
    var cell: GridCell
    @Binding var showPopover: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            if let component = cell.component {
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
                Button {
                    showPopover = false
                    grid.cellToDelete = cell
                } label: {
                    Text("Delete")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(RoundedRectangleButtonStyle(color: .red))
                .padding(.top, 8)
                    
            } else {
                ComponentPurchaseView(cell: cell)
                    .environment(grid)
                    .padding(.vertical, -6)
            }
        }
        .frame(width: 224)
        .foregroundColor(.white)
        .padding(32)
        .roundedRectangleGlass(cornerRadius: 32)
        .disabled(grid.tutorial)
    }
}
