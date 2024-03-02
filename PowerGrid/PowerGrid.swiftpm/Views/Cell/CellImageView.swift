import SwiftUI

struct CellImageView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var brightness: Double {
        switch grid.currentHour {
        case 6, 18:
            return -0.1
        case 7...17:
            return 0
        default:
            return -0.2
        }
    }
    
    var component: any Component
    @State var degree: Double = 0
    
    var body: some View {
        ZStack {
            if (component is NaturalGas || component is Industrial) && component.active {
                VortexView(.smoke) {
                    Circle()
                        .fill(.white)
                        .frame(width: 6)
                        .blur(radius: 3)
                        .tag("circle")
                }
                .offset(x: component is Industrial ? 21 : 19,
                        y: -22)
                .transition(.opacity)
            }
            if component is WindTurbine {
                TimelineView(.animation(minimumInterval: 1/60,
                                        paused: !component.active)) { context in
                    ZStack {
                        Image("wind1")
                            .resizable()
                            
                        ZStack {
                            Image("wind2")
                                .resizable()
                                .rotationEffect(.degrees(
                                     degree
                                ))
                            Image("wind3")
                                .resizable()
                        }.offset(y:-8)
                    }
                    .brightness(brightness)
                    .animation(nil, value: context.date)
                    .onChange(of: context.date) { _, _ in
                        if degree == 358 {
                            degree = 0
                        } else {
                            degree += 2
                        }
                        
                    }
                }
            } else {
                Image(component.imageName)
                    .resizable()
                    .brightness(brightness)
            }
            if (component is Hydroelectric) && component.active {
                VortexView(.splash) {
                    Circle()
                        .fill(.white)
                        .frame(width: 20, height: 20)
                        .tag("circle")
                }
                .frame(width: 50, height: 50)
                .offset(y: -5)
                .blur(radius: 1)
                .transition(.opacity)
            }
        }
        .grayscale(grid.currentSunlightData.weather == .lightRains || grid.currentSunlightData.weather == .heavyRains || grid.currentSunlightData.weather == .cloudy ? 0.6 : 0)
        .frame(width: 100, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .transition(.scale)
        .animation(.easeIn, value: component.active)
    }
    
    func computeAngle(date: Date) -> Double {
        let s = Calendar.current.dateComponents([.second], from: date).second!
        let ns = Calendar.current.dateComponents([.nanosecond], from: date).nanosecond!
        
        return (Double(s % 3) * 120) + (Double(ns) / 8333333.33333)
    }
}

