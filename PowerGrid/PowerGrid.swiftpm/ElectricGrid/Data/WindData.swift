import Foundation

public struct WindData: GridData {
    public let id: UUID = UUID()
    
    public let date: Date
    public var amount: Int
    
    public init(_ dateAndTime: String, amount: Int) {
        self.amount = amount
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-HH"
        
        self.date = dateFormatter.date(from: dateAndTime) ?? Date.distantPast
    }
    public init(_ date: Date, amount: Int) {
        self.amount = amount
        self.date = date
    }
}

