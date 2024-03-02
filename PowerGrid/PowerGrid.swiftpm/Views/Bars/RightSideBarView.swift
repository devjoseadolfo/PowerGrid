//
//  SwiftUIView.swift
//  
//
//  Created by Jose Adolfo Talactac on 2/29/24.
//

import SwiftUI

struct RightSideBarView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var body: some View {
        VStack {
            if let cell = grid.selectedCell {
                CellPopoverView(cell: cell)
                    .transition(.opacity)
                    .padding(32)
            } else {
                Rectangle()
                    .fill(.clear)
                    .frame(height: 128)
            }
        }
        .roundedRectangleGlass(cornerRadius: 32)
        .padding(16)
        .opacity(grid.selectedCell == nil ? 0 : 1)
        .animation(.default, value: grid.selectedCell)
    }
}

