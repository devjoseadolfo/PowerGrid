import SwiftUI

struct DarkDivider: View {
    var body: some View {
        Divider()
            .frame(minWidth: 1, maxHeight: 16)
            .overlay(Color.black.opacity(0.25))
    }
}
