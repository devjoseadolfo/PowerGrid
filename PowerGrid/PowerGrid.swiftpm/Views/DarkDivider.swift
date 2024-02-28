import SwiftUI

struct DarkDivider: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 16))
            path.closeSubpath()
        }
        .stroke(.black.opacity(0.4), lineWidth: 1)
        .frame(width: 1, height: 16)
    }
}
