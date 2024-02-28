import SwiftUI
import Charts

struct DemandInfoView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var body: some View {
        GlassGroupBox(title: "Demand Forecast", symbolName: "powercord.fill") {
            VStack(spacing: 10) {
                Chart(grid.consumptionData) {
                    BarMark(x: .value("Time", $0.date, unit: .hour),
                            y: .value("Demand", $0.amount),
                            width: 12)
                    .foregroundStyle(by: .value("Consumption Category", $0.componentType))
                }
                .chartForegroundStyleScale(range: UtilityData.graphColors(for: grid.consumptionData))
                .chartYAxis {
                    AxisMarks(position: .leading) { value in
                        if let power = value.as(Int.self) {
                            AxisValueLabel(String(power)+" MW")
                                .foregroundStyle(Color(white: 0.95))
                        }
                        AxisGridLine()
                            .foregroundStyle(Color(white: 0.95))
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .hour)) { value in
                        if let date = value.as(Date.self) {
                            let hour = Calendar.current.component(.hour, from: date)
                            if hour % 3 == 0 && value.index < 11 {
                                AxisValueLabel(hour < 13 ? String(hour == 0 ? 12 : hour) + "AM" :  String(hour-12) + "PM")
                                    .foregroundStyle(Color(white: 0.95))
                                AxisTick()
                                    .foregroundStyle(Color(white: 0.95))
                            }
                        }
                        AxisGridLine(centered: false)
                            .foregroundStyle(Color(white: 0.95))
                    }
                }
             
                .chartLegend(position: .bottom, alignment: .top, spacing: 16) {
            
                }
                .animation(.linear, value: grid.consumptionData[0].date)
                .frame(minHeight: UIScreen.main.bounds.height > 800 ? 120 : 80, maxHeight: 150)
                
                if UIScreen.main.bounds.height > 800 {
                    HStack {
                        Circle()
                            .frame(width: 9, height: 9)
                            .foregroundColor(Color.init(red: 0.9, green: 0.2, blue: 0.2))
                        Text("Residential")
                            .foregroundStyle(Color(white: 0.95))                            .font(.system(size: 12))
                        Circle()
                            .frame(width: 9, height: 9)
                            .foregroundColor(Color.init(red: 0.7, green: 0.2, blue: 0.2))
                        Text("Commercial")
                            .foregroundStyle(Color(white: 0.95))                            .font(.system(size: 12))
                        Circle()
                            .frame(width: 9, height: 9)
                            .foregroundColor(Color.init(red: 0.5, green: 0.2, blue: 0.2))
                        Text("Industrial")
                            .foregroundStyle(Color(white: 0.95))                            .font(.system(size: 12))
                    }
                }
            }
            .padding(.top, 8)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}
