import SwiftUI
import Charts

struct CustomerDemandChartView: View {
    var customer: any Customer
    @Environment(ElectricGrid.self) private var grid
    
    var body: some View {
        Chart(generateUtilityData()) {
            BarMark(x: .value("Time", $0.date, unit: .hour),
                    y: .value("Wind Speed", $0.amount),
                    width: 10)
            .foregroundStyle(.tint)
        }
        .chartYAxis {
            AxisMarks(position: .leading) { value in
                if let power = value.as(Int.self) {
                    AxisValueLabel(String(power)+" MW")
                        .font(.system(size: 8))
                        .foregroundStyle(Color.init(white: 0.95))
                }
                AxisGridLine()
                    .foregroundStyle(Color.init(white: 0.95))
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .hour)) { value in
                if let date = value.as(Date.self) {
                    let hour = Calendar.current.component(.hour, from: date)
                    if hour % 3 == 0 && value.index < 11 {
                        AxisValueLabel(hour < 13 ? String(hour == 0 ? 12 : hour) + "AM" :  String(hour-12) + "PM")
                            .font(.system(size: 8))
                            .foregroundStyle(Color.init(white: 0.95))
                        AxisTick()
                            .foregroundStyle(Color.init(white: 0.95))
                    }
                }
                AxisGridLine(centered: false)
                    .foregroundStyle(Color.init(white: 0.95))
            }
        }
        .frame(maxHeight: 100)
    }
    
    func generateUtilityData() -> [UtilityData] {
        return customer
            .demandForecast
            .enumerated()
            .map { (index, amount) in
                let componentType: ComponentType = {
                    switch customer {
                    case is Residential:
                        return .residential
                    case is Commercial:
                        return .commercial
                    default:
                        return .industrial
                    }
                }()
                return UtilityData(grid.date + Double(60 * 60 * index),
                        amount: amount,
                        componentType: componentType,
                        utilityDataType: .consumption)
        }
    }
}
