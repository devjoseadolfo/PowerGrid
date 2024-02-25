import SwiftUI

struct ComponentPurchaseView: View {
    @Environment(ElectricGrid.self) private var grid
    @State var showPowerPlants: Bool = true
    var cell: GridCell
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Button {
                    showPowerPlants = true
                } label: {
                    Text("Power Plants")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .padding(4)
                        .padding(.horizontal, 8)
                        .background(showPowerPlants ? Color.init(white: 0.25).opacity(0.5) : Color.clear)
                        .clipShape(Capsule())
                }
                Button {
                    showPowerPlants = false
                } label: {
                    Text("Customers")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .padding(4)
                        .padding(.horizontal, 8)
                        .background(!showPowerPlants ?  Color.init(white: 0.25).opacity(0.5) : Color.clear)
                        .clipShape(Capsule())
                }
            }
            VStack {
                if showPowerPlants {
                    ForEach(0..<grid.samplePowerPlants.count, id: \.self) { idx in
                        HStack {
                            Image(grid.samplePowerPlants[idx].imageName)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .background(Color.init(white: 0.15).opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding(8)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(grid.samplePowerPlants[idx].name)
                                    .font(.system(size: 16,
                                                  weight: .bold))
                                    .foregroundStyle(.white)
                                Text("Price: ")
                                    .font(.system(size: 12,
                                                  weight: .regular))
                                    .foregroundStyle(Color.init(white: 0.9).opacity(0.85))

                                + Text(moneyString(grid.samplePowerPlants[idx].price()))
                                    .font(.system(size: 12,
                                                  weight: .regular,
                                                  design: .monospaced))
                                    .foregroundStyle(Color.init(white: 0.9).opacity(0.85))
                                Text("Production: ")
                                    .font(.system(size: 12,
                                                  weight: .regular))
                                    .foregroundStyle(Color.init(white: 0.9).opacity(0.85))

                                + Text(grid.samplePowerPlants[idx].productionLevel.rawValue)
                                    .font(.system(size: 12,
                                                  weight: .regular,
                                                  design: .monospaced))
                                    .foregroundStyle(Color.init(white: 0.9).opacity(0.85))
                                Text("Maintenance: ")
                                    .font(.system(size: 12,
                                                  weight: .regular))
                                    .foregroundStyle(Color.init(white: 0.9).opacity(0.85))

                                + Text(grid.samplePowerPlants[idx].maintenanceLevel.rawValue)
                                    .font(.system(size: 12,
                                                  weight: .regular,
                                                  design: .monospaced))
                                    .foregroundStyle(Color.init(white: 0.9).opacity(0.85))
                            }
                            Spacer()
                        }
                        .frame(width: 240)
                        .roundedRectangleGlass(cornerRadius: 16, material: .thin)
                        .transition(.opacity)
                        .grayscale(grid.money >= grid.samplePowerPlants[idx].price() ? 0 : 1.0)
                        .opacity(grid.money >= grid.samplePowerPlants[idx].price() ? 1.0 : 0.25)
                        .onTapGesture {
                            addPowerPlant(samplePowerPlant: grid.samplePowerPlants[idx])
                        }
                        .disabled(grid.money < grid.samplePowerPlants[idx].price())
                    }
                } else {
                    ForEach(0..<grid.sampleCustomers.count, id: \.self) { idx in
                        HStack {
                            Image(grid.sampleCustomers[idx].imageName)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .background(Color.init(white: 0.15).opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding(8)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(grid.sampleCustomers[idx].name)
                                    .font(.system(size: 16,
                                                  weight: .bold))
                                    .foregroundStyle(.white)
                                Text("Price: ")
                                    .font(.system(size: 12,
                                                  weight: .regular))
                                    .foregroundStyle(Color.init(white: 0.9).opacity(0.85))
                                + Text(moneyString(grid.sampleCustomers[idx].price()))
                                    .font(.system(size: 12,
                                                  weight: .regular,
                                                  design: .monospaced))
                                    .foregroundStyle(Color.init(white: 0.9).opacity(0.85))
                                Text("Demand: ")
                                    .font(.system(size: 12,
                                                  weight: .regular))
                                    .foregroundStyle(Color.init(white: 0.9).opacity(0.85))
                                + Text(grid.sampleCustomers[idx].demandLevel.rawValue)
                                    .font(.system(size: 12,
                                                  weight: .regular,
                                                  design: .monospaced))
                                    .foregroundStyle(Color.init(white: 0.9).opacity(0.85))
                                Text("Payment: ")
                                    .font(.system(size: 12,
                                                  weight: .regular))
                                    .foregroundStyle(Color.init(white: 0.9).opacity(0.85))

                                + Text(grid.sampleCustomers[idx].demandLevel.rawValue)
                                    .font(.system(size: 12,
                                                  weight: .regular,
                                                  design: .monospaced))
                                    .foregroundStyle(Color.init(white: 0.9).opacity(0.85))
                            }
                            Spacer()
                        }
                        .frame(width: 240)
                        .roundedRectangleGlass(cornerRadius: 16, material: .thin)
                        .transition(.opacity)
                        .grayscale(grid.money >= grid.sampleCustomers[idx].price() ? 0 : 1.0)
                        .opacity(grid.money >= grid.sampleCustomers[idx].price() ? 1.0 : 0.25)
                        .onTapGesture {
                            if grid.money >= grid.sampleCustomers[idx].price() {
                                addCustomer(sampleCustomer: grid.sampleCustomers[idx])
                            }
                        }
                        .disabled(grid.money < grid.sampleCustomers[idx].price())
                    }
                }
            }
            .frame(height: 512)
        }
        .animation(.easeIn, value: showPowerPlants)
        .disabled(grid.tutorial)
    }
    
    func moneyString(_ money: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return "$" + (numberFormatter.string(from: NSNumber(value: money)) ?? "0")
    }
    
    func addCustomer(sampleCustomer: any Customer) {
        grid.money -= sampleCustomer.price()
        let customer: any Customer = {
            switch sampleCustomer {
            case is Industrial:
                return Industrial(startHour: grid.currentHour)
            case is Commercial:
                return Commercial(startHour: grid.currentHour)
            default:
                return Residential(startHour: grid.currentHour)
            }
        }()
        customer.demand = 0
        customer.demandForecast[0] = 0
        grid.addComponent(customer, at: cell.index)
    }
    
    func addPowerPlant(samplePowerPlant: any PowerPlant) {
        grid.money -= samplePowerPlant.price()
        let powerPlant: any PowerPlant = {
            switch samplePowerPlant {
            case is WindTurbine:
                return WindTurbine()
            case is SolarFarm:
                return SolarFarm()
            case is NaturalGas:
                return NaturalGas()
            case is Hydroelectric:
                return Hydroelectric()
            default:
                return BatteryStorage()
            }
        }()
        grid.addComponent(powerPlant, at: cell.index)
    }
}


