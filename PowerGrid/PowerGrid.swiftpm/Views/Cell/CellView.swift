import SwiftUI
import Popovers

struct CellView: View {
    @Environment(ElectricGrid.self) private var grid
    
    @State var showPopover: Bool = false
    
    var cell: GridCell
    
    var body: some View {
        image
        .frame(width: 96, height: 96)
        .background(Color(white: 0.9).opacity(0.25))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .onTapGesture {
            grid.selectedCell = grid.selectedCell == cell ? nil : cell
        }
        .animation(.easeIn, value: grid.date)
        .animation(.easeIn, value: grid.selectedCell)
        .animation(.easeIn, value: cell.component?.id)
        .overlay {
            notification
        }
        .overlay {
            glance
        }
        .padding(.vertical, 8)
    }
    
    var image: some View {
        ZStack {
            if let component = cell.component {
                CellImageView(component: component)
            } else {
                Image(systemName: "plus")
                    .font(.system(size: 40))
                    .foregroundStyle(
                        LinearGradient(colors: [.white.opacity(0.75),
                                                             .white.opacity(0.9)],
                                                    startPoint: .top,
                                                    endPoint: .bottom)
                    )
            }
            if grid.selectedCell == cell {
                Color.green
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .blendMode(.color)
                    .transition(.opacity)
            }
        }
    }
    
    var glance: some View {
        ZStack {
            if let component = cell.component {
                CellGlanceView(component: component)
            }
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .offset(y:18)
    }
    
    var notification: some View {
        ZStack {
            if let windTurbine = cell.component as? WindTurbine {
                PowerPlantNotificationView(powerPlant: windTurbine)
            } else if let solarFarm = cell.component as? SolarFarm {
                PowerPlantNotificationView(powerPlant: solarFarm)
            } else if let naturalGas = cell.component as? NaturalGas {
                PowerPlantNotificationView(powerPlant: naturalGas)
            } else if let hydroelectric = cell.component as? Hydroelectric {
                PowerPlantNotificationView(powerPlant: hydroelectric)
            } else if let residential = cell.component as? Residential {
                CustomerPaymentNotificationView(customer: residential)
            } else if let commercial = cell.component as? Commercial {
                CustomerPaymentNotificationView(customer: commercial)
            } else if let industrial = cell.component as? Industrial {
                CustomerPaymentNotificationView(customer: industrial)
            } else if let batteryStorage = cell.component as? BatteryStorage {
                PowerPlantNotificationView(powerPlant: batteryStorage)
            }
        }
    }
}
