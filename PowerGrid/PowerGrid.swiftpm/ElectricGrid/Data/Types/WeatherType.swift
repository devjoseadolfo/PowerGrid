import Foundation
import Charts
import SwiftUI

public enum WeatherType: String, Plottable {
    case lightRains = "Light Rains"
    case heavyRains = "Heavy Rains"
    case sunny = "Sunny"
    case cloudy = "Cloudy"
    case night = "Night"
    
    var symbol: String {
        switch self {
        case .sunny:
            return "sun.max.fill"
        case .night:
            return "moon.fill"
        case .cloudy:
            return "cloud.fill"
        case .lightRains:
            return "cloud.drizzle.fill"
        case .heavyRains:
            return "cloud.heavyrain.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .sunny:
            return .init(red: 0.95, green: 0.75, blue: 0.05)
        case .night:
            return .init(white: 0.25)
        case .cloudy:
            return .init(white: 0.75)
        case .lightRains:
            return .init(red: 0.55, green: 0.75, blue: 0.9)
        case .heavyRains:
            return .init(red: 0.1, green: 0.2, blue: 0.85)
        }
    }
}
