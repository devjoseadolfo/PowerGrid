import Foundation

public protocol Customer: Component {
    var demand: Int { get set }
    var maxDemand: Int { get set }
    var demandForecast: [Int] { get set }
    static var perUnitCurve: [Double] { get }
    
    var payRate: Double { get }
    var lastPayment: Int { get set }
    
    var demandLevel: LevelType { get }
    var paymentLevel: LevelType { get }

    func createInitialDemandForecast(startHour: Int) -> [Int]
    func addToDemandForecast(currentHour: Int)
    func computeDemand(hour: Int) -> Int
    func computePay(percent: Double) -> Int
    
}

extension Customer {
    
    public func createInitialDemandForecast(startHour: Int) -> [Int] {
        var newDemandForecast: [Int] = []
        for hour in (startHour...startHour+11) {
            let newHour = hour > 23 ? hour - 24 : hour
            newDemandForecast.append(computeDemand(hour: newHour))
        }
        return newDemandForecast
    }
    
    public func addToDemandForecast(currentHour: Int) {
        demandForecast.removeFirst()
        demand = demandForecast[0]
        let futureHour = currentHour + 11 
        demandForecast.append(computeDemand(hour: futureHour > 23 
                                        ? futureHour - 24
                                        : futureHour))
    }
    public func computeDemand(hour: Int) -> Int {
        let newPU = Self.perUnitCurve[hour] + Double.random(in: -0.1...0.1)
        let newDemand = Int(newPU * Double(maxDemand))
        return newDemand > maxDemand ? maxDemand : newDemand
    }
    
    public func computePay(percent: Double) -> Int {
        if percent < 1 {
            lastPayment = Int(Double(demand) * payRate * percent)
        } else {
            lastPayment = Int(Double(demand) * payRate) + 10
        }
        return lastPayment
    }
}

@Observable
public class Residential: Customer {
    public var name = "Residential"
    static public var count = 0
    public let imageName: String = "residential"
    public let id: UUID = UUID()
    
    public var active: Bool = true
    
    public var demand: Int = 0
    public var maxDemand: Int = 20
    public var demandForecast: [Int] = []
    
    public let payRate: Double = 2.5
    public var lastPayment: Int = 0
    
    public let demandLevel: LevelType = .low
    public let paymentLevel: LevelType = .low
    
    public let basePrice: Int = 500
    public let multiplierPrice: Int = 100
    
    public static let perUnitCurve: [Double] = [0.55, 0.50, 0.45, 0.40, 0.40, 0.40,
                                         0.45, 0.60, 0.70, 0.60, 0.45, 0.40,
                                         0.40, 0.40, 0.40, 0.40, 0.60, 0.80,
                                         0.90, 0.95, 1.00, 0.90, 0.80, 0.60]
    
    public init(startHour: Int = 8) {
        Self.count += 1
        demandForecast = createInitialDemandForecast(startHour: startHour)
        demand = demandForecast[0]
    }
}


@Observable
public class Commercial: Customer {
    public var name = "Commercial"
    static public var count = 0
    public let imageName: String = "commercial"
    public let id: UUID = UUID()
    
    public var active: Bool = true
    
    public var demand: Int = 0
    public var maxDemand: Int = 30
    public var demandForecast: [Int] = []
    
    public let payRate: Double = 4
    public var lastPayment: Int = 0
    
    public let demandLevel: LevelType = .medium
    public let paymentLevel: LevelType = .medium
    
    public let basePrice: Int = 1000
    public let multiplierPrice: Int = 100
    
    public static let perUnitCurve: [Double] = [0.20, 0.20, 0.20, 0.20, 0.20, 0.20,
                                                0.20, 0.30, 0.50, 0.80, 1.00, 1.00,
                                                0.90, 0.90, 1.00, 1.00, 1.00, 0.80,
                                                0.50, 0.30, 0.20, 0.20, 0.20, 0.20]
    
    public init(startHour: Int = 8) {
        Self.count += 1
        demandForecast = createInitialDemandForecast(startHour: startHour)
        demand = demandForecast[0]
    }
}

@Observable
public class Industrial: Customer {
    public var name = "Industrial"
    static public var count = 0
    public let imageName: String = "industrial"
    public let id: UUID = UUID()
    
    public var active: Bool = true
    
    public var demand: Int = 0
    public var maxDemand: Int = 40
    public var demandForecast: [Int] = []
    
    public let payRate: Double = 5
    public var lastPayment: Int = 0
    
    public let demandLevel: LevelType = .high
    public let paymentLevel: LevelType = .high
    
    public let basePrice: Int = 2000
    public let multiplierPrice: Int = 200
    
    public static let perUnitCurve: [Double] = [0.40, 0.40, 0.40, 0.40, 0.40, 0.40,
                                                0.50, 0.60, 0.90, 1.00, 1.00, 1.00,
                                                0.95, 0.95, 1.00, 1.00, 0.90, 0.60,
                                                0.50, 0.45, 0.40, 0.40, 0.40, 0.40]
    
    public init(startHour: Int = 8) {
        Self.count += 1
        demandForecast = createInitialDemandForecast(startHour: startHour)
        demand = demandForecast[0]
    }
}
