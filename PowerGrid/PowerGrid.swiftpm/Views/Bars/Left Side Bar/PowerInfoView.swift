import SwiftUI
import Charts

struct PowerInfoView: View {
    @Environment(ElectricGrid.self) private var grid
    @State private var showPopover = false
    var body: some View {
        GlassGroupBox(title: "Power Production",
                      symbolName: "bolt.fill") {
            Chart(grid.currentUtilityData) { data in
                BarMark(x: .value("Power", data.amount),
                        y: .value("Utility Type", data.utilityDataType))
                    .foregroundStyle(by: .value("Category", data.componentType))
            }
            .chartForegroundStyleScale(range: UtilityData.graphColors(for: grid.currentUtilityData))
            .frame(height: 96)
            .chartLegend(.hidden)
            .chartYAxis {
                AxisMarks(position: .leading) { _ in
                    AxisValueLabel()
                        .foregroundStyle(Color(white: 0.95))
                }
            }
            .chartXAxis {
                AxisMarks(position: .bottom, values: .automatic(desiredCount: 5)) { value in
                    AxisGridLine()
                        .foregroundStyle(Color(white: 0.95))
                    AxisTick()
                        .foregroundStyle(Color(white: 0.95))
                    if let power = value.as(Int.self) {
                        AxisValueLabel(String(power)+" MW")
                            .foregroundStyle(Color(white: 0.95))
                    }
                }
            }
            .animation(.linear, value: grid.currentUtilityData)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}
