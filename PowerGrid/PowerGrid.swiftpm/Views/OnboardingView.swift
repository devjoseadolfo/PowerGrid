import SwiftUI

struct OnboardingView: View {
    @Environment(ElectricGrid.self) private var grid
    
    var body: some View {
        VStack(spacing: 16) {
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
            Text("PowerGrid puts you in charge of managing a city's electric grid. Are you up for the challenge?")
                .font(.system(size: 16))
                .frame(width: 250)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.85))
            Spacer()
                .frame(height: 8)
            Button {
                grid.tutorial = true
                grid.tutorialLevel = 1
                grid.showOnboarding = false
            } label: {
                Text("Start Tutorial")
                    .font(.system(size: 16, weight: .bold))
            }
            .buttonStyle(RoundedRectangleButtonStyle(color: .green))
            .frame(width: 200)
            Button {
                grid.tutorial = false
                grid.tutorialLevel = 0
                grid.showOnboarding = false
            } label: {
                Text("Skip Tutorial")
                    .font(.system(size: 16, weight: .bold))
            }
            .buttonStyle(RoundedRectangleButtonStyle(color: .init(white: 0.6)))
            .frame(width: 200)
        }
        .frame(width: 384, height: 512)
        .roundedRectangleGlass(cornerRadius: 32)
        .transition(.opacity)
    }
}

