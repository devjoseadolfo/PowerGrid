import SwiftUI

struct GridView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var columns: [GridItem] { Array.init(repeating: GridItem(.fixed(96), spacing: 16), count: grid.columnCount) }
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .center) {
            ForEach(grid.cells) { cell in
                CellView(cell: cell)
            }
        }
    }
}
