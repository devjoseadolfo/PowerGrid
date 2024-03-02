import SwiftUI

struct CustomerPaymentNotificationView<C: Customer> : View {
    @Environment(ElectricGrid.self) private var grid
    var customer: C
    
    var body: some View {
        Text("+$" + String(customer.lastPayment))
            .animation(nil, value: customer.lastPayment)
            .font(.system(size: 12, weight: .bold, design: .monospaced))
            .foregroundStyle(.white)
            .padding(8)
            .background(.green)
            .clipShape(Capsule())
            .phaseAnimator([false, true], trigger: grid.date) { content, phase in
                content
                    .offset(y: phase && customer.lastPayment > 0 ? -50 : -20)
                    .opacity(phase && customer.lastPayment > 0 ? 1.0 : 0.0)
                    .shadow(radius: phase && customer.lastPayment > 0 ? 8.0 : 0.0, 
                            y: phase && customer.lastPayment > 0 ? 4.0 : 0.0)
            } animation: { _ in
                    .bouncy.speed(0.5).delay(0.1)
            }
    }
}

struct PowerPlantNotificationView<P: PowerPlant> : View {
    @Environment(ElectricGrid.self) private var grid
    var powerPlant: P
    
    var body: some View {
        Text("-$" + String(powerPlant.runningCost))
            .font(.system(size: 12, weight: .bold, design: .monospaced))
            .foregroundStyle(.white)
            .padding(8)
            .background(.red)
            .clipShape(Capsule())
            .phaseAnimator([false, true], trigger: grid.date) { content, phase in
                content
                    .offset(y: phase && powerPlant.active ? -50 : -20)
                    .opacity(phase && powerPlant.active ? 1.0 : 0.0)
                    .shadow(radius: phase ? 8.0 : 0.0, y: phase && powerPlant.active ? 4.0 : 0.0)
            } animation: { _ in
                    .bouncy.speed(0.5).delay(0.25)
            }
    }
}

struct InsufficientProductionNotificationView : View {
    @Environment(ElectricGrid.self) private var grid
    
    var body: some View {
        Text("INSUFFICIENT PRODUCTION")
            .font(.system(size: 12, design: .monospaced))
            .foregroundStyle(.black)
            .padding(8)
            .padding(.horizontal, 4)
            .capsuleGlass(shadowRadius: 8)
            .phaseAnimator([false, true], trigger: grid.hearts) { content, phase in
                content
                    .offset(y: phase && grid.hearts < 5 ? -64 : -32)
                    .opacity(phase && grid.hearts < 5 ? 1.0 : 0.0)
                    
            } animation: { _ in
                    .bouncy.speed(0.5).delay(0.25)
            }
    }
}
