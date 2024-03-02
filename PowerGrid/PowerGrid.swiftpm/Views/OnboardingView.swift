import SwiftUI

struct OnboardingView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var body: some View {
        VStack(spacing: 24) {
            VStack {
                Image("icon")
                    .resizable()
                    .frame(width: 128, height: 128)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    .shadow(radius: 16, y: 16)
                Image("title")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 256, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    .shadow(radius: 16, y: 16)
            }
            Text("PowerGrid puts you in charge of managing a city's electric grid. Are you up for the challenge?")
                .bodyTextStyle()
                .multilineTextAlignment(.center)
                .frame(width: 256)
            VStack(spacing: 8) {
                Button {
                    grid.showOnboarding = false
                } label: {
                    Text("New Game")
                        .buttonTextStyle()
                }
                .buttonStyle(RoundedRectangleButtonStyle(color: .green))
                Button {
                   
                } label: {
                    Text("Open Save")
                        .buttonTextStyle()
                }
                .buttonStyle(RoundedRectangleButtonStyle(color: .gray))
                .disabled(true)
                .opacity(0.5)
            }
            .frame(width: 256)
        }
        .padding(64)
        .roundedRectangleGlass(cornerRadius: 64)
        .transition(.opacity)
    }
}

