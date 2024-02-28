import SwiftUI
import Charts

struct WindInfoView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var body: some View {
        GlassGroupBox(title: "Wind Forecast", symbolName: "wind") {
            Chart(grid.windData) {
                BarMark(x: .value("Time", $0.date, unit: .hour),
                        y: .value("Wind Speed", $0.amount),
                        width: 12)
            }
            .foregroundStyle(
                Color(red: 0.1, green: 0.75, blue: 1.0)
            )
            .chartYScale(domain: [0, 100])
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    if let wind = value.as(Int.self) {
                        AxisValueLabel(String(wind) + "%")
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
                            AxisGridLine()
                                .foregroundStyle(Color(white: 0.95))
                        }
                    }
                   
                }
            }
            .animation(.linear, value: grid.windData[0].date)       
            .frame(maxHeight: 90)
            .padding(.top, 10)
            .padding(16)
        }
    }
}
