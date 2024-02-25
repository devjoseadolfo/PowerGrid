import Foundation

public struct SunlightData: GridData {
    public let id: UUID = UUID()
    
    public let date: Date
    public var amount: Int
    public let weather: WeatherType
    
    public init(_ dateAndTime: String, amount: Int, weather: WeatherType) {
        self.amount = amount
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-HH"
        self.date = dateFormatter.date(from: dateAndTime) ?? Date.distantPast
        self.weather = weather
    }
    
    public init(_ date: Date, amount: Int, weather: WeatherType) {
        self.amount = amount
        self.date = date
        self.weather = weather
    }
}
