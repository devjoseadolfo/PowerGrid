import SwiftUI
import Charts

struct SunlightInfoView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var body: some View {
        GlassGroupBox(title: "Sunlight Forecast", symbolName: "sun.max.fill") {
            Chart(grid.sunlightData) { data in
                BarMark(x: .value("Time", data.date, unit: .hour),
                        y: .value("Wind Speed", data.amount),
                        width: 12)
                .annotation(position: .top) {
                    Image(systemName: data.weather.symbol)
                        .font(.system(size: 12, weight: .black))
                        .foregroundStyle(data.weather.color)
                }
                .foregroundStyle(data.weather.color)
            }
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    if let percent = value.as(Int.self) {
                        AxisValueLabel(String(percent) + "%")
                            .foregroundStyle(Color(white: 0.95))
                    }
                    AxisGridLine()
                        .foregroundStyle(Color(white: 0.95))
                }
            }
            .chartYScale(domain: [0, 100])
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
                    AxisGridLine()
                        .foregroundStyle(Color(white: 0.95))
                }
            }
            .animation(.linear, value: grid.sunlightData[0].date)
            .frame(maxHeight: 90)
            .padding(.top, 16)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}
