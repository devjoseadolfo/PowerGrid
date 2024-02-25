import SwiftUI

@Observable
public class ElectricGrid {
    public var debug: Bool = false
    
    public var cells: [GridCell] = []
    public var rowCount: Int
    public var columnCount: Int
    
    public var hearts: Int = 5
    
    public var customers: [any Customer] = []
    public var powerPlants: [any PowerPlant] = []
    
    public var date: Date
    public let startDate: Date

    public var currentHour: Int {
        let components = Calendar.current.dateComponents([.hour], from: date)
        return components.hour ?? 0
    }
    
    public var currentSunlightData: SunlightData {
        sunlightData[0]
    }
    public var currentWindData: WindData {
        windData[0]
    }
    
    public var currentUtilityData: [UtilityData] = []
    
    /*
    public var currentUtilityData: [UtilityData] {
       productionData + [consumptionData[0], consumptionData[1], consumptionData[2], batteryConsumption]
    }
    */
    public var currentTotalProduction: Int {
        productionData.reduce(0) { x, y in
            x + y.amount
        }
    }
    
    public var currentTotalConsumption: Int {
        consumptionData[0].amount + consumptionData[1].amount + consumptionData[2].amount
    }
    
    public var money: Int = 1_000
    public var playing: Bool = false
    
    public var productionData: [UtilityData] = []
    public var consumptionData: [UtilityData] = []
    
    public var windData: [WindData] = []
    
    public var sunlightData: [SunlightData] = []
    
    public var batteryConsumption: UtilityData
    
    public let samplePowerPlants: [any PowerPlant] = [NaturalGas(), SolarFarm(), WindTurbine(), Hydroelectric(), BatteryStorage()]
    public let sampleCustomers: [any Customer] = [Residential(), Commercial(), Industrial()]
    
    public var showOnboarding: Bool = true
    public var tutorial: Bool = false
    public var tutorialLevel: Int = 0
    public var newGame: Bool = false
    public var cellToDelete: GridCell?
    public var sufficientFundsError: Bool = false
        
    public init(rowCount: Int, columnCount: Int) {
        self.rowCount = rowCount
        self.columnCount = columnCount
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-HH"
        let date = dateFormatter.date(from: "01-01-08") ?? Date.distantPast
        self.startDate = date
        self.date = date
        self.batteryConsumption = .init(date,
                                   amount: 0,
                                   componentType: .storage,
                                   utilityDataType: .consumption)
        
        self.sunlightData = generateInitialSunlightData()
        self.windData = generateInitialWindData()
        for i in 0..<rowCount {
            for j in 0..<columnCount {
                cells.append(GridCell(index: j + (i * columnCount)))
            }
        }
        
        addComponent(Commercial(), at: 10)
        addComponent(Residential(), at: 11)
        addComponent(SolarFarm(), at: 12)
        addComponent(NaturalGas(), at: 13)
        addComponent(NaturalGas(), at: 14)
        cells[14].component?.active = false
    /*
        addComponent(WindTurbine(), at: 15)
        addComponent(Hydroelectric(), at: 16)
        addComponent(Industrial(), at: 17)
        addComponent(WindTurbine(), at: 18)
        addComponent(BatteryStorage(), at: 19)
       */
        sunlightData[0] = SunlightData(date,
                                       amount: 20,
                                       weather: .sunny)
        
        generateInitialConsumptionData()
        setProduction()
        
        
        currentUtilityData = productionData + [consumptionData[0], consumptionData[1], consumptionData[2], batteryConsumption]
        
        money = 1_000
        
        Industrial.count = 0
        Commercial.count = 0
        Residential.count = 0
        BatteryStorage.count = 0
        WindTurbine.count = 0
        SolarFarm.count = 0
        NaturalGas.count = 0
        Hydroelectric.count = 0
    }
    
    public func addHour() {
        date += 60 * 60
        productionData = []
        
        restoreMaintenance()
        
        addReservoirLevels()
        sunlightData.remove(at: 0)
        sunlightData.append(ElectricGrid.generateSunlightData(date: date + (60 * 60 * 11)))
        windData.remove(at: 0)
        windData.append(ElectricGrid.generateWindData(date: date + (60 * 60 * 11)))
        
        updateDemandForecast()
        setProduction()
        
        if currentTotalConsumption > currentTotalProduction {
            hearts -= 1
        }
        
        currentUtilityData[0].amount = productionData[0].amount
        currentUtilityData[1].amount = productionData[1].amount
        currentUtilityData[2].amount = productionData[2].amount
        currentUtilityData[3].amount = productionData[3].amount
        currentUtilityData[4].amount = productionData[4].amount
        currentUtilityData[5].amount = consumptionData[0].amount
        currentUtilityData[6].amount = consumptionData[1].amount
        currentUtilityData[7].amount = consumptionData[2].amount
        currentUtilityData[8].amount = batteryConsumption.amount
    }
    
}

extension ElectricGrid {
    public func restoreMaintenance() {
        for powerPlant in self.powerPlants {
            if !powerPlant.active {
                powerPlant.addMaintenance(100)
            }
        }
    }
    
    public func setProduction() {
        resetPowerPlantProduction()
        subtractTotalRunningCost()
        setDependablePowerPlants()
        setFlexiblePowerPlants()
        storeSurplusProduction()
        addTotalPay()
    }
    
    public func addTotalPay() {
        let percent = Double(currentTotalProduction) / Double(currentTotalConsumption)
        let totalPay = customers.reduce(0) { x, customer in
            x + customer.computePay(percent: percent)
        }
        money += totalPay
    }
    
    public func storeSurplusProduction() {
        guard currentTotalConsumption < currentTotalProduction else {
            batteryConsumption = .init(date,
                                        amount: 0,
                                        componentType: .storage,
                                        utilityDataType: .consumption)
            return
        }
        var surplus = currentTotalProduction - currentTotalConsumption
        
        
        var batteries = powerPlants.filter {
            $0 is BatteryStorage && $0.active
        }.map {
            $0 as! BatteryStorage
        }
        
        var count = batteries.count
        guard count > 0 else {
            return
        }
        
        while surplus > 0 && batteries.count > 0 {
            var distributedSurplus = surplus / count
            distributedSurplus = distributedSurplus == 0 ? 1 : distributedSurplus
            for battery in batteries {
                let tempStorage = battery.store(distributedSurplus)
                guard let tempStorage = tempStorage else {
                    if let i = batteries.firstIndex(where: { $0.id == battery.id }) {
                        batteries.remove(at: i)
                        count -= 1
                    }
                    continue
                }
                surplus -= tempStorage
                if surplus == 0 || count == 0 {
                    break
                }
            }
            if surplus == 0 || count == 0 {
                break
            }
        }
        let batteryConsumptionAmount =  powerPlants.filter {
            $0 is BatteryStorage && $0.active
        }.map {
            $0 as! BatteryStorage
        }.reduce(0) { x, storage in
            x + storage.stored
        }
        batteryConsumption = .init(date,
                                    amount: batteryConsumptionAmount,
                                    componentType: .storage,
                                    utilityDataType: .consumption)
    }
    
    public func setFlexiblePowerPlants() {
        guard currentTotalConsumption > currentTotalProduction else {
            productionData.append(.init(date,
                                        amount: 0,
                                        componentType: .gas,
                                        utilityDataType: .production))
            productionData.append(.init(date,
                                        amount: 0,
                                        componentType: .hydro,
                                        utilityDataType: .production))
            productionData.append(.init(date,
                                        amount: 0,
                                        componentType: .storage,
                                        utilityDataType: .production))
            return
        }
        var deficit = currentTotalConsumption - currentTotalProduction
        var naturalGasProduction = 0
        var hydroelectricProduction = 0
        var batteryProduction = 0
        
        var flexibles = powerPlants.filter {
            $0 is (any FlexiblePowerPlant) && $0.active
        }.map {
            $0 as! (any FlexiblePowerPlant)
        }
        
        var count = flexibles.count
        guard count > 0 else {
            productionData.append(.init(date,
                                        amount: 0,
                                        componentType: .gas,
                                        utilityDataType: .production))
            productionData.append(.init(date,
                                        amount: 0,
                                        componentType: .hydro,
                                        utilityDataType: .production))
            productionData.append(.init(date,
                                        amount: 0,
                                        componentType: .storage,
                                        utilityDataType: .production))
            return
        }
        
        while deficit > 0 && flexibles.count > 0 {
            var distributedDemand = deficit / count
            distributedDemand = distributedDemand == 0 ? 1 : distributedDemand
            for flexible in flexibles {
                let tempProduction = flexible.produce(distributedDemand)
                guard let tempProduction = tempProduction else {
                    if let i = flexibles.firstIndex(where: { $0.id == flexible.id }) {
                        flexibles.remove(at: i)
                        count -= 1
                    }
                    continue
                }
                deficit -= tempProduction
                
                if flexible is NaturalGas {
                    naturalGasProduction += tempProduction
                } else if flexible is Hydroelectric {
                    hydroelectricProduction += tempProduction
                } else if flexible is BatteryStorage {
                    batteryProduction += tempProduction
                }
                if deficit == 0 || count == 0 {
                    break
                }
            }
            if deficit == 0 || count == 0 {
                break
            }
        }
        
        productionData.append(.init(date,
                                    amount: naturalGasProduction,
                                    componentType: .gas,
                                    utilityDataType: .production))
        productionData.append(.init(date,
                                    amount: hydroelectricProduction,
                                    componentType: .hydro,
                                    utilityDataType: .production))
        productionData.append(.init(date,
                                    amount: batteryProduction,
                                    componentType: .storage,
                                    utilityDataType: .production))
    }
    
    public func setDependablePowerPlants() {
        var solarFarmProduction = 0
        var windTurbineProduction = 0
        for powerPlant in self.powerPlants {
            if let solarFarm = powerPlant as? SolarFarm, solarFarm.active {
                solarFarm.produce(amount: currentSunlightData.amount)
                solarFarmProduction += solarFarm.production
            }
            if let windTurbine = powerPlant as? WindTurbine, windTurbine.active {
                windTurbine.produce(amount: currentWindData.amount)
                windTurbineProduction += windTurbine.production
            }
        }
        
        productionData.append(.init(date,
                                    amount: solarFarmProduction,
                                    componentType: .solar,
                                    utilityDataType: .production))
        productionData.append(.init(date,
                                    amount: windTurbineProduction,
                                    componentType: .wind,
                                    utilityDataType: .production))
    }
    
    public func addReservoirLevels() {
        for powerPlant in self.powerPlants {
            if let hydroelectric = powerPlant as? Hydroelectric {
                switch currentSunlightData.weather {
                case .heavyRains:
                    hydroelectric.addReservoirLevel(200)
                case .lightRains:
                    hydroelectric.addReservoirLevel(100)
                case .sunny:
                    hydroelectric.addReservoirLevel(20)
                default:
                    hydroelectric.addReservoirLevel(40)
                }
            }
        }
    }
    
    public func updateDemandForecast() {
        for customer in self.customers {
            customer.addToDemandForecast(currentHour: currentHour)
        }
    
        consumptionData.removeFirst()
        consumptionData.removeFirst()
        consumptionData.removeFirst()
        
        var industrialAmount = 0
        var commercialAmount = 0
        var residentialAmount = 0
        for customer in customers {
            switch customer {
            case is Industrial:
                industrialAmount += customer.demandForecast[11]
            case is Commercial:
                commercialAmount += customer.demandForecast[11]
            default:
                residentialAmount += customer.demandForecast[11]
            }
        }
        
        let futureDate = date + (11 * 60 * 60)
        consumptionData.append(UtilityData(futureDate,
                                           amount: industrialAmount,
                                           componentType: .industrial,
                                           utilityDataType: .consumption))
        consumptionData.append(UtilityData(futureDate,
                                           amount: commercialAmount,
                                           componentType: .commercial,
                                           utilityDataType: .consumption))
        consumptionData.append(UtilityData(futureDate,
                                           amount: residentialAmount,
                                           componentType: .residential,
                                           utilityDataType: .consumption))
    }
    
    public func subtractTotalRunningCost() {
        money -= calculateTotalRunningCost()
    }
    
    public func calculateTotalRunningCost() -> Int {
        return powerPlants
            .filter { $0.active }
            .reduce(0) { x, powerPlant in
                x + powerPlant.runningCost
            }
    }
    
    public func resetPowerPlantProduction() {
        for powerPlant in self.powerPlants {
            powerPlant.production = 0
            if let storage = powerPlant as? BatteryStorage {
                storage.stored = 0
            }
        }
    }
}
