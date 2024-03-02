import Foundation

public protocol PowerPlant: Component {
    var production: Int { get set }
    var maxProduction: Int { get set }
    
    var maintenance: Int { get set }
    var maintenanceRate: Int { get }
    
    var runningCost: Int { get }
    
    var productionLevel: LevelType { get }
    var maintenanceLevel: LevelType { get }
    
    func addMaintenance(_ amount: Int)
    func subtractMaintenance(_ amount: Int)
    func resetProduction()
}

public protocol DependablePowerPlant: PowerPlant {
    func produce(amount: Int)
}

public protocol FlexiblePowerPlant: PowerPlant {
    func produce(_ demand: Int) -> Int?
}

public protocol StoragePowerPlant: FlexiblePowerPlant {
    var storage: Int { get set }
    var maxStorage: Int { get set }
}

extension PowerPlant {
    public func addMaintenance(_ amount: Int) {
        let newAmount = maintenance + amount
        maintenance = newAmount > 1000 ? 1000 : newAmount
    }
    
    public func subtractMaintenance(_ amount: Int) {
        let newAmount = maintenance - amount
        if newAmount < 0 {
            maintenance = 0
        } else {
            maintenance = newAmount
        }
    }

    public func resetProduction() {
        production = 0
    }
}


@Observable
public class WindTurbine: DependablePowerPlant {
    public var name = "Wind Turbine"
    static public var count = 0
    public let imageName: String = "wind"
    public let id: UUID = UUID()
    
    public var active: Bool = true
    
    public var production: Int = 0
    public var maxProduction: Int = 30
    
    public var maintenance: Int = 800
    public let maintenanceRate: Int = 3
    
    public let runningCost: Int = 30
    
    public var productionLevel: LevelType = .medium
    public var maintenanceLevel: LevelType = .high
    
    public let basePrice: Int = 800
    public let multiplierPrice: Int = 100
    
    public init() {
        Self.count += 1
    }
    
    public func produce(amount: Int = 0) {
        guard maintenance > 0 else {
            production = 0
            active = false
            return
        }
        production = Int(maxProduction * amount / 100)
        subtractMaintenance(production * maintenanceRate)
    }
}


@Observable
public class SolarFarm: DependablePowerPlant {
    public var name = "Solar"
    static public var count = 0
    public let imageName: String = "solar"
    public let id: UUID = UUID()
    
    public var active: Bool = true
    
    public var production: Int = 0
    public var maxProduction: Int = 30

    public var maintenance: Int = 800
    public let maintenanceRate: Int = 1
    
    public let runningCost: Int = 20
    
    public var productionLevel: LevelType = .low
    public var maintenanceLevel: LevelType = .low
    
    public let basePrice: Int = 500
    public let multiplierPrice: Int = 50
    
    public init() {
        Self.count += 1
    }
    
    public func produce(amount: Int = 0) {
        guard maintenance > 0 else {
            production = 0
            active = false
            return
        }
        production = Int(maxProduction * amount / 100)
        subtractMaintenance(production * 3 / 2)
    }
}


@Observable
public class Hydroelectric: FlexiblePowerPlant {
    public var name = "Hydroelectric"
    static public var count = 0
    public let imageName: String = "hydro"
    public let id: UUID = UUID()
    
    public var active: Bool = true
    
    public var production: Int = 0
    public var maxProduction: Int = 40
    public let productionRate: Int = 5
    
    public var maintenance: Int = 800
    public let maintenanceRate: Int = 2
    
    public var reservoirLevel: Int = 800
    public let runningCost: Int = 40
    
    public var productionLevel: LevelType = .high
    public var maintenanceLevel: LevelType = .medium
    
    public let basePrice: Int = 3000
    public let multiplierPrice: Int = 200
    
    public init() {
        Self.count += 1
    }
    
    public func addReservoirLevel(_ amount: Int) {
        let newAmount = reservoirLevel + amount
        reservoirLevel = newAmount > 1000 ? 1000 : newAmount
    }
    
    public func subtractReservoirLevel(_ amount: Int) {
        let newAmount = reservoirLevel - amount
        if newAmount < 0 {
            reservoirLevel = 0
        } else {
            reservoirLevel = newAmount
        }
    }
    
    public func resetReservoirLevel() {
        reservoirLevel = 0
    }
    
    public func produce(_ demand: Int) -> Int? {
        guard active, reservoirLevel > 0, maintenance > 0 else {
            active = false
            return nil
        }
        
        guard maxProduction > production else {
            return nil
        }
        
        let maxProductionPerReservoir = reservoirLevel / productionRate
        
        guard maxProductionPerReservoir >= demand else {
            resetReservoirLevel()
            subtractMaintenance(maxProductionPerReservoir * maintenanceRate)
            production += maxProductionPerReservoir
            return maxProductionPerReservoir
        }
        
        guard maxProduction >= (demand + production) else {
            let tempProduction = maxProduction - production
            subtractReservoirLevel(tempProduction * productionRate)
            subtractMaintenance(tempProduction * maintenanceRate)
            production += tempProduction
            return tempProduction
        }
        
        production += demand
        subtractReservoirLevel(demand * productionRate)
        subtractMaintenance(demand * maintenanceRate)
        
        return demand
    }
}


@Observable
public class NaturalGas: FlexiblePowerPlant {
    public var name = "Natural Gas"
    static public var count = 0
    public let imageName: String = "gas"
    public let id: UUID = UUID()
    
    public var active: Bool = true
    
    public var production: Int = 0
    public var maxProduction: Int = 50
    public let productionRate: Int = 5
    
    public var maintenance: Int = 800
    public let maintenanceRate: Int = 3
    
    public let runningCost: Int = 40
    
    public var fuelLevel: Int = 800
    public var maxFuelLevel: Int = 1000
    
    public var productionLevel: LevelType = .high
    public var maintenanceLevel: LevelType = .high
    
    public let basePrice: Int = 1000
    public let multiplierPrice: Int = 250
    
    public init() {
        Self.count += 1
    }
    
    public func addFuelLevel(_ amount: Int) {
        let newAmount = fuelLevel + amount
        fuelLevel = newAmount > maxFuelLevel ? 1000 : newAmount
    }
    
    public func subtractFuelLevel(_ amount: Int) {
        let newAmount = fuelLevel - amount
        if newAmount < 0 {
            fuelLevel = 0
        } else {
            fuelLevel = newAmount
        }
    }
    
    public func resetFuelLevel() {
        fuelLevel = 0
        production = 0
    }
    
    public func getFuelPrice(fuelAmount: Int) -> Int {
        let price: Double = Double(fuelAmount) / 10 * 2
        return Int(price.rounded(.up))
    }
    
    public func produce(_ demand: Int) -> Int? {
        guard active, fuelLevel > 0, maintenance > 0 else {
            active = false
            return nil
        }
        
        guard maxProduction > production  else {
            return nil
        }
        
        let maxProductionPerFuel = fuelLevel / productionRate
        
        guard maxProductionPerFuel >= demand else {
            resetFuelLevel()
            subtractMaintenance(maxProductionPerFuel * maintenanceRate)
            production += maxProductionPerFuel
            return maxProductionPerFuel
        }
        
        guard maxProduction >= (demand + production) else {
            let tempProduction = maxProduction - production
            subtractFuelLevel(tempProduction * productionRate)
            subtractMaintenance(tempProduction * maintenanceRate)
            production += tempProduction
            return tempProduction
        }
        
        production += demand
        subtractFuelLevel(demand * productionRate)
        subtractMaintenance(demand * maintenanceRate)
        
        return demand
    }
}


@Observable
public class BatteryStorage: StoragePowerPlant {
    public var name = "Battery Storage"
    static public var count = 0
    public let imageName: String = "storage"
    public let id: UUID = UUID()
    
    public var active: Bool = true
    
    public var production: Int = 0
    public var maxProduction: Int = 10
    
    public var consumption: Int = 0
    public var maxConsumption: Int = 10
    
    public var storage: Int = 0
    public var maxStorage: Int = 100
    public var stored: Int = 0
    
    public var maintenance: Int = 800
    public let maintenanceRate: Int = 1
    
    public let runningCost: Int = 20
    
    public var productionLevel: LevelType = .low
    public var maintenanceLevel: LevelType = .medium
    
    public let basePrice: Int = 2000
    public let multiplierPrice: Int = 200
    
    public init() {
        Self.count += 1
    }
    
    public func produce(_ demand: Int) -> Int? {
        guard active, maintenance > 0 else {
            active = false
            return nil
        }
        
        guard maxProduction > production, storage > 0  else {
            return nil
        }
        
        guard maxProduction >= (demand + production) else {
            let tempProduction = maxProduction - production
            subtractStorage(tempProduction)
            subtractMaintenance(tempProduction * maintenanceRate)
            production += tempProduction
            return tempProduction
        }
        
        production += demand
        subtractStorage(production)
        subtractMaintenance(demand * maintenanceRate)
        
        return demand
    }
    
    public func store(_ amount: Int) -> Int? {
        guard active, maintenance > 0 else {
            active = false
            return nil
        }
        
        guard amount > 0 else {
            return nil
        }
        
        guard storage < maxStorage else {
            return nil
        }
        
        guard stored < 20 else {
            return nil
        }
        
        guard 20 >= (amount + stored) else {
            guard maxStorage >= (amount + stored) else {
                let tempStorage = maxStorage - stored
                addStorage(tempStorage)
                subtractMaintenance(tempStorage * maintenanceRate)
                return tempStorage
            }
            let tempStorage = 20 - stored
            addStorage(tempStorage)
            subtractMaintenance(tempStorage * maintenanceRate)
            return tempStorage
        }
        
        guard maxStorage >= (amount + stored) else {
            let tempStorage = maxStorage - stored
            addStorage(tempStorage)
            subtractMaintenance(tempStorage * maintenanceRate)
            return tempStorage
        }
        
        addStorage(amount)
        subtractMaintenance(amount * maintenanceRate)
        
        return amount
    }
    
    public func resetStorage() {
        storage = 0
        production = 0
    }
    
    public func subtractStorage(_ amount: Int) {
        let newAmount = storage - amount
        if newAmount < 0 {
            storage = 0
        } else {
            storage = newAmount
        }
    }
    
    public func addStorage(_ amount: Int) {
        let newAmount = storage + amount
        if newAmount > maxStorage {
            stored += maxStorage - storage
            storage = maxStorage
        } else {
            stored += amount
            storage = newAmount
        }
    }
}
