import Foundation
import Charts
import SwiftUI

public struct UtilityData: GridData, Equatable {
    public let id: UUID = UUID()
    
    public let componentType: ComponentType
    public let utilityDataType: UtilityDataType
    public var date: Date
    public var amount: Int
    
    public init(_ dateAndTime: String, 
                amount: Int,
                componentType: ComponentType,
                utilityDataType: UtilityDataType) {
        self.amount = amount
        self.componentType = componentType
        self.utilityDataType = utilityDataType
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-HH"
        
        self.date = dateFormatter.date(from: dateAndTime) ?? Date.distantPast
    }
    
    public init(_ date: Date, 
                amount: Int, 
                componentType: ComponentType,
                utilityDataType: UtilityDataType) {
        self.amount = amount
        self.date = date
        self.componentType = componentType
        self.utilityDataType = utilityDataType
    }
    
    public static func graphColors(for input: [UtilityData]) -> [Color] {
        var returnColors = [Color]()
        for data in input {
            switch data.componentType {
            case .commercial:
                returnColors.append(.init(red: 0.7, green: 0.2, blue: 0.2))
            case .industrial:
                returnColors.append(.init(red: 0.5, green: 0.2, blue: 0.2))
            case .residential:
                returnColors.append(.init(red: 0.9, green: 0.2, blue: 0.2))
            case .solar:
                returnColors.append(.init(red: 0.95, green: 0.75, blue: 0.05))
            case .wind:
                returnColors.append(.init(red: 0.1, green: 0.75, blue: 1.0))
            case .gas:
                returnColors.append(.init(red: 0.65, green: 0.1, blue: 0.9))
            case .hydro:
                returnColors.append(.init(red: 0.05, green: 0.25, blue: 0.9))
            case .storage:
                returnColors.append(.init(red: 0.2, green: 0.7, blue: 0.2))
            }
        }
        return returnColors
    }
    
}
