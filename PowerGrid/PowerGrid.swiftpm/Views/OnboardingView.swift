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
                .frame(width: 250)
            VStack {
                Button {
                    grid.tutorial = true
                    grid.tutorialLevel = 1
                    grid.showOnboarding = false
                } label: {
                    Text("Start Tutorial")
                        .buttonTextStyle()
                }
                .buttonStyle(RoundedRectangleButtonStyle(color: .green))
                Button {
                    grid.tutorial = false
                    grid.tutorialLevel = 0
                    grid.showOnboarding = false
                } label: {
                    Text("Skip Tutorial")
                        .buttonTextStyle()
                }
                .buttonStyle(RoundedRectangleButtonStyle(color: .init(white: 0.6)))
            } 
            .frame(width: 200)
        }
        .padding(64)
        .roundedRectangleGlass(cornerRadius: 64)
        .transition(.opacity)
    }
}

