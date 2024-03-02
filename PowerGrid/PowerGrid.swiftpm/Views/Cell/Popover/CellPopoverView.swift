import SwiftUI

struct CellPopoverView: View {
    @Environment(ElectricGrid.self) private var grid
    var cell: GridCell
    
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
                            component.toggle()
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
                }
                
                VStack(spacing: 16) {
                    Group {
                        ComponentInfoView(component: component)
                        if let customer = component as? (any Customer) {
                            CustomerDemandChartView(customer: customer)
                                .padding(.top, 4)
                                .tint(customer is Industrial ? .init(red: 0.5, green: 0.2, blue: 0.2) : (customer is Commercial ? .init(red: 0.7, green: 0.2, blue: 0.2) : .init(red: 0.9, green: 0.2, blue: 0.2)))
                                .padding([.top], -8)
                        }
                    }
                    Button {
                        grid.cellToDelete = cell
                    } label: {
                        Text("Delete")
                            .buttonTextStyle()
                    }
                    .buttonStyle(RoundedRectangleButtonStyle(color: .red))
                }
            } else {
                ComponentPurchaseView(cell: cell)
                    .environment(grid)
            }
        }
        .foregroundColor(.white)
        .transition(.opacity)
        .id(cell.id)
    }
}
