import SwiftUI

struct CircularProgressView: View {
    var color: Color
    var symbol: String
    var currentValue: Double
    var maxValue: Double
    var body: some View {
        ZStack {
            Image(systemName: symbol)
                .foregroundStyle(color)
                .font(.system(size: 12))
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(
                    color.opacity(0.375),
                    style: StrokeStyle(
                        lineWidth: 4,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(135))
            Circle()
                .trim(from: 0, to: 0.75*(currentValue/maxValue))
                .stroke(
                    color,
                    // 1
                    style: StrokeStyle(
                        lineWidth: 4,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(135))
        }
        .frame(width: 24, height: 24)
        .animation(.easeInOut, value: currentValue)
    }
}


