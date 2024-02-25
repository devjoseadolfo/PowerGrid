import SwiftUI

struct CellView: View {
    @Environment(ElectricGrid.self) private var grid
    var cell: GridCell
    @State var showPopover: Bool = false

    var body: some View {
        ZStack{
            CellBackgroundView()
                .grayscale(cell.component == nil ? 0.9 : 0)
            if cell.component == nil {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.white.opacity(0.80))
                    .contentTransition(.symbolEffect(.replace))
                if showPopover {
                    Color.green
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .blendMode(.color)
                }
            } else if let windTurbine = cell.component as? WindTurbine {
                CellImageView(component: windTurbine)
                if showPopover {
                    Color.green
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .blendMode(.color)
                }
                CellGlanceView(component: windTurbine)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y:18)
                PowerPlantNotificationView(powerPlant: windTurbine)
            } else if let solarFarm = cell.component as? SolarFarm {
                CellImageView(component: solarFarm)
                if showPopover {
                    Color.green
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .blendMode(.color)
                }
                CellGlanceView(component: solarFarm)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y:18)
                PowerPlantNotificationView(powerPlant: solarFarm)
            } else if let naturalGas = cell.component as? NaturalGas {
                CellImageView(component: naturalGas)
                if showPopover {
                    Color.green
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .blendMode(.color)
                }
                CellGlanceView(component: naturalGas)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y:18)
                PowerPlantNotificationView(powerPlant: naturalGas)
            } else if let hydroelectric = cell.component as? Hydroelectric {
                CellImageView(component: hydroelectric)
                if showPopover {
                    Color.green
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .blendMode(.color)
                }
                CellGlanceView(component: hydroelectric)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y:18)
                PowerPlantNotificationView(powerPlant: hydroelectric)
            } else if let residential = cell.component as? Residential {
                CellImageView(component: residential)
                if showPopover {
                    Color.green
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .blendMode(.color)
                }
                CellGlanceView(component: residential)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y:18)
                CustomerPaymentNotificationView(customer: residential)
            } else if let commercial = cell.component as? Commercial {
                CellImageView(component: commercial)
                if showPopover {
                    Color.green
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .blendMode(.color)
                }
                CellGlanceView(component: commercial)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y:18)
                CustomerPaymentNotificationView(customer: commercial)
            } else if let industrial = cell.component as? Industrial {
                CellImageView(component: industrial)
                if showPopover {
                    Color.green
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .blendMode(.color)
                }
                CellGlanceView(component: industrial)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y:18)
                CustomerPaymentNotificationView(customer: industrial)
            } else if let batteryStorage = cell.component as? BatteryStorage {
                CellImageView(component: batteryStorage)
                if showPopover {
                    Color.green
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .blendMode(.color)
                }
                CellGlanceView(component: batteryStorage)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y:18)
                PowerPlantNotificationView(powerPlant: batteryStorage)
            }
           
        }
        .popover(present: $showPopover, 
                 attributes: {
            $0.presentation.animation = .easeIn
            $0.position = .absolute(originAnchor: .left, popoverAnchor: .right)
            $0.sourceFrameInset.left = -10
            $0.dismissal.mode = ((grid.tutorialLevel > 4 && grid.tutorialLevel < 8) && cell.index == 13) || (grid.tutorialLevel == 9 && cell.index == 7) ? .none : .tapOutside
            $0.dismissal.tapOutsideIncludesOtherPopovers = true
            $0.rubberBandingMode = .none
            $0.presentation.transition = .opacity
        },
                 view: { 
            CellPopoverView(cell: cell, 
                            showPopover: $showPopover)
                    .environment(grid)
        })
        .onTapGesture {
            if !grid.tutorial {
                showPopover.toggle()
            }
        }
        .animation(.easeIn, value: grid.date)
        .animation(.easeIn, value: cell.component?.id)
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
        .padding(.vertical, 10)
    }
}
