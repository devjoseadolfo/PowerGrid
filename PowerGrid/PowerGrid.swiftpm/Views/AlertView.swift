import SwiftUI

struct AlertView: View {
    var title: String
    var message: String
    var actionName: String
    var action: () -> Void
    var buttonColor: Color
    var secondaryActionName: String?
    var secondaryAction: (() -> Void)?
    var secondaryButtonColor: Color?
    
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
            Text(message)
                .font(.system(size: 16, weight: .regular))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.85))
            Button {
                action()
            } label: {
                Text(actionName)
                    .font(.system(size: 16, weight: .bold))
            }
            .buttonStyle(RoundedRectangleButtonStyle(color: buttonColor))
            .padding(.top, 8)
            if let secondaryActionName = secondaryActionName,
               let secondaryAction = secondaryAction,
               let secondaryButtonColor = secondaryButtonColor {
                Button {
                    secondaryAction()
                } label: {
                    Text(secondaryActionName)
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(RoundedRectangleButtonStyle(color: secondaryButtonColor))
            }
        }
        .frame(width: 240)
        .padding(32)
        .roundedRectangleGlass(cornerRadius: 32)
        .transition(.opacity)
    }
}

