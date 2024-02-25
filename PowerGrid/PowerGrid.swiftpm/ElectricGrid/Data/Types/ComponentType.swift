import Foundation
import Charts

public enum ComponentType: String, Plottable {
    case gas = "Natural Gas"
    case wind = "Wind"
    case solar = "Solar"
    case hydro = "Hydro"
    case industrial = "Industrial"
    case commercial = "Commercial"
    case residential = "Residential"
    case storage = "Storage"
}
