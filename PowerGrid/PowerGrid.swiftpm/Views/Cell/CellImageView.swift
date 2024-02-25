import SwiftUI

struct CellImageView<C: Component>: View {
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
    
    @ObservedObject var component: C
    
    @State private var degree: Double = 0
    @State private var amountOfIncrease: Double = 0
    @State private var isRotating: Bool = false

    let timer = Timer.publish(every: 6 / 360, on: .main, in: .common).autoconnect()
    
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
                Image("wind1")
                    .resizable()
                    .brightness(brightness)
                ZStack {
                    Image("wind2")
                        .resizable()
                        .brightness(brightness)
                        .rotationEffect(.degrees(degree))
                        .onAppear {
                            self.isRotating = true
                            self.amountOfIncrease = 3
                        }
                    Image("wind3")
                        .resizable()
                        .brightness(brightness)
                }
                .offset(y:-8)
                .onReceive(self.timer) { _ in
                    withAnimation(.linear) { 
                        self.degree += self.amountOfIncrease
                    }
                    if degree > 360 {
                        degree -= 360
                    }
                }
                .onChange(of: component.active) { _, newValue in
                    isRotating = true
                    self.amountOfIncrease = newValue ? 3 : 0
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
}

