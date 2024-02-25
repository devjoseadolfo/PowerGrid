import Foundation

@Observable
public class GridCell: Identifiable, Equatable {
    public var index: Int
    public var component: (any Component)?
    public var id: UUID = UUID()
    
    public init(index: Int) {
        self.index = index
    }
    
    public static func == (lhs: GridCell, rhs: GridCell) -> Bool {
        lhs.id == rhs.id
    }
}
