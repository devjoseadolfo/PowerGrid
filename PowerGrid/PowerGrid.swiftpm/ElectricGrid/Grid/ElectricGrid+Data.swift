import Foundation

extension ElectricGrid {
    public static func generateSunlightData(date: Date) -> SunlightData {
        let components = Calendar.current.dateComponents([.hour], from: date)
        let hour = components.hour ?? 0
        var amount: Int = {
            switch hour {
            case 6, 18:
                return 6 + Int.random(in: -2...2)
            case 7, 17:
                return 10 + Int.random(in: -4...4)
            case 8, 16:
                return 20 + Int.random(in: -5...5)
            case 9, 15:
                return 30 + Int.random(in: -6...6)
            case 10, 14:
                return 60 + Int.random(in: -8...8)
            case 11, 13:
                return 80 + Int.random(in: -10...10)
            case 12:
                return 100 + Int.random(in: -5...0)
            default:
                return 0
            }
        }()
        
        let random = Int.random(in: 1...100)
        
        let weather: WeatherType = {
            switch random {
            case 1..<11:
                if hour > 5 && hour < 19 {
                    amount = amount / 2
                    return .cloudy
                } else {
                    return .night
                }
            case 11..<26:
                amount = 0
                return .lightRains
            case 26..<36:
                amount = 0
                return .heavyRains
            default:
                if hour > 5 && hour < 19 {
                    return .sunny
                } else {
                    return .night
                }
            }
        }()
        
        return SunlightData(date, amount: amount, weather: weather)
    }
    
    public func generateInitialSunlightData() -> [SunlightData] {
        var newDate = date
        var sunlightData: [SunlightData] = []
        for _ in 1...12 {
            sunlightData.append(Self.generateSunlightData(date: newDate))
            newDate += (60 * 60)
        }
        return sunlightData
    }
    
    public static func generateWindData(date: Date) -> WindData {
        let amount = Int.random(in: 5...90)
        return WindData(date, amount: amount)
    }
    
    public func generateInitialWindData() -> [WindData] {
        var newDate = date
        var windData: [WindData] = []
        for _ in 1...12 {
            windData.append(Self.generateWindData(date: newDate))
            newDate += (60 * 60)
        }
        return windData
    }
    
    public func generateInitialConsumptionData() {
        var dataDate = date
        for i in 0...11 {
            var industrialAmount = 0
            var commercialAmount = 0
            var residentialAmount = 0
            for customer in customers {
                switch customer {
                case is Industrial:
                    industrialAmount += customer.demandForecast[i]
                case is Commercial:
                    commercialAmount += customer.demandForecast[i]
                default:
                    residentialAmount += customer.demandForecast[i]
                }
            }
            consumptionData.append(UtilityData(dataDate,
                                               amount: industrialAmount,
                                               componentType: .industrial,
                                               utilityDataType: .consumption))
            consumptionData.append(UtilityData(dataDate,
                                               amount: commercialAmount,
                                               componentType: .commercial,
                                               utilityDataType: .consumption))
            consumptionData.append(UtilityData(dataDate,
                                               amount: residentialAmount,
                                               componentType: .residential,
                                               utilityDataType: .consumption))
            dataDate += 60 * 60
        }
    }
}
