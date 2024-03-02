import Foundation

public protocol Component: AnyObject, Identifiable, Equatable {
    var name: String { get }
    static var count: Int { get set }
    var imageName: String { get }
    var id: UUID { get }
    
    var active: Bool { get set }
    
    var basePrice: Int { get }
    var multiplierPrice: Int { get }
    
    func price() -> Int
}

extension Component {
    func toggle() {
        active.toggle()
    }
    
    public func price() -> Int {
        return basePrice + (Self.count * multiplierPrice)
    }
}

extension Component {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
