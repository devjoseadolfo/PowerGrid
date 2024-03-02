import SwiftUI

struct CellView: View {
    @Environment(ElectricGrid.self) private var grid
    
    @State var showPopover: Bool = false
    
    var cell: GridCell
    
    var body: some View {
        ZStack {
            image
            if grid.selectedCell == cell {
                Color.green
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .blendMode(.color)
            }
        }
        .frame(width: 96, height: 96)
        .background(Color(white: 0.9).opacity(0.25))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .onTapGesture {
            if !grid.tutorial {
                grid.selectedCell = grid.selectedCell == cell ? nil : cell
            }
        }
        .animation(.easeIn, value: grid.date)
        .animation(.easeIn, value: cell.component?.id)
        .overlay {
            notification
        }
        .overlay {
            glance
        }
        .overlay {
            if cell.index == 24 && grid.tutorialLevel == 1 {
                Tutorial1View()
                    .offset(x: -120, y: -68)
            }
            if cell.index == 22 && grid.tutorialLevel == 2 {
                Tutorial2View()
                    .offset(x: -175, y: -80)
            }
            if cell.index == 24 && grid.tutorialLevel == 5 {
                Tutorial5View()
                    .offset(x: -325, y: 25)
            }
            if cell.index == 24 && grid.tutorialLevel == 6 {
                Tutorial6View()
                    .offset(x: -640, y: -220)
            }
            if cell.index == 24 && grid.tutorialLevel == 7 {
                Tutorial7View()
                    .offset(x: -640, y: -140)
            }
            if cell.index == 19 && grid.tutorialLevel == 9 {
                Tutorial9View()
                    .offset(x: -30, y: -235)
            }
    
        }
        .onChange(of: grid.tutorialLevel, {
            if cell.index == 13 {
                if grid.tutorialLevel > 4 && grid.tutorialLevel < 8 {
                   showPopover = true
                } else {
                    showPopover = false
                }
            }
            if cell.index == 7 {
                if grid.tutorialLevel == 9 {
                   showPopover = true
                } else {
                    showPopover = false
                }
            }
        })
        .padding(.vertical, 8)
    }
    
    var image: some View {
        ZStack {
            if cell.component == nil {
                Image(systemName: "plus")
                    .font(.system(size: 40))
                    .foregroundStyle(
                        LinearGradient(colors: [.white.opacity(0.75),
                                                             .white.opacity(0.9)],
                                                    startPoint: .top,
                                                    endPoint: .bottom)
                    )
            } else if let windTurbine = cell.component as? WindTurbine {
                CellImageView(component: windTurbine)
            } else if let solarFarm = cell.component as? SolarFarm {
                CellImageView(component: solarFarm)
            } else if let naturalGas = cell.component as? NaturalGas {
                CellImageView(component: naturalGas)
            } else if let hydroelectric = cell.component as? Hydroelectric {
                CellImageView(component: hydroelectric)
            } else if let residential = cell.component as? Residential {
                CellImageView(component: residential)
            } else if let commercial = cell.component as? Commercial {
                CellImageView(component: commercial)
            } else if let industrial = cell.component as? Industrial {
                CellImageView(component: industrial)
            } else if let batteryStorage = cell.component as? BatteryStorage {
                CellImageView(component: batteryStorage)
            }
        }
    }
    
    var glance: some View {
        ZStack {
            if let windTurbine = cell.component as? WindTurbine {
                CellGlanceView(component: windTurbine)
            } else if let solarFarm = cell.component as? SolarFarm {
                CellGlanceView(component: solarFarm)
            } else if let naturalGas = cell.component as? NaturalGas {
                CellGlanceView(component: naturalGas)
            } else if let hydroelectric = cell.component as? Hydroelectric {
                CellGlanceView(component: hydroelectric)
            } else if let residential = cell.component as? Residential {
                CellGlanceView(component: residential)
            } else if let commercial = cell.component as? Commercial {
                CellGlanceView(component: commercial)
            } else if let industrial = cell.component as? Industrial {
                CellGlanceView(component: industrial)
            } else if let batteryStorage = cell.component as? BatteryStorage {
                CellGlanceView(component: batteryStorage)
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
