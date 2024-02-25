import SwiftUI

public struct Tutorial1View: View {
    @Environment(ElectricGrid.self) private var grid
    public var body: some View {
        VStack(spacing: 0) {
            Text("These are your power plants. Power plants produce the power for your city. Different power plants have different production capacities and requirements.")
                .padding(24)
                .multilineTextAlignment(.center)
                .frame(width: 300, height: 170)
                .roundedRectangleGlass(cornerRadius: 16)
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .yellow))
                .grayscale(1)
                .opacity(0.5)
                .disabled(true)
                Button {
                    grid.tutorialLevel = 2
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .green))
            }
            .padding(4)
            .padding(.horizontal, 4)
            .capsuleGlass()
            .offset(y: -20)
        }
        .environment(\.colorScheme, .dark)
    }
}


public struct Tutorial2View: View {
    @Environment(ElectricGrid.self) private var grid
    public var body: some View {
        VStack(spacing: 0) {
            Text("These are your customers. Your customers have varying demand per hour. Different types of customers have different demand levels.")
                .padding(24)
                .multilineTextAlignment(.center)
                .frame(width: 340, height: 150)
                .roundedRectangleGlass(cornerRadius: 16)
            HStack {
                Button {
                    grid.tutorialLevel = 1
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .yellow))
                Button {
                    grid.tutorialLevel = 3
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .green))
            }
            .padding(4)
            .padding(.horizontal, 4)
            .capsuleGlass()
            .offset(y: -20)
        }
        .environment(\.colorScheme, .dark)
    }
}


public struct Tutorial3View: View {
    @Environment(ElectricGrid.self) private var grid
    public var body: some View {
        VStack(spacing: 0) {
            Text("You have to make sure your power production meets your power consumption. Otherwise, you will lose a heart. ")
                .padding(24)
                .multilineTextAlignment(.center)
                .frame(width: 300, height: 140)
                .roundedRectangleGlass(cornerRadius: 16)
            HStack {
                Button {
                    grid.tutorialLevel = 2
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .yellow))
                Button {
                    grid.tutorialLevel = 4
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .green))
            }
            .padding(4)
            .padding(.horizontal, 4)
            .capsuleGlass()
            .offset(y: -20)
        }
        .environment(\.colorScheme, .dark)
    }
}


public struct Tutorial4View: View {
    @Environment(ElectricGrid.self) private var grid
    public var body: some View {
        VStack(spacing: 0) {
            Text("If you lose all 5 hearts, it’s game over.")
                .padding(24)
                .multilineTextAlignment(.center)
                .frame(width: 240, height: 100)
                .roundedRectangleGlass(cornerRadius: 16)
            HStack {
                Button {
                    grid.tutorialLevel = 3
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .yellow))
                Button {
                    grid.tutorialLevel = 5
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .green))
            }
            .padding(4)
            .padding(.horizontal, 4)
            .capsuleGlass()
            .offset(y: -20)
        }
        .environment(\.colorScheme, .dark)
    }
}


public struct Tutorial5View: View {
    @Environment(ElectricGrid.self) private var grid
    public var body: some View {
        VStack(spacing: 0) {
            Text("You can tap on a power plant or customer to view more information about it.")
                .padding(24)
                .multilineTextAlignment(.center)
                .frame(width: 280, height: 120)
                .roundedRectangleGlass(cornerRadius: 16)
            HStack {
                Button {
                    grid.tutorialLevel = 4
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .yellow))
                Button {
                    grid.tutorialLevel = 6
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .green))
            }
            .padding(4)
            .padding(.horizontal, 4)
            .capsuleGlass()
            .offset(y: -20)
        }
        .environment(\.colorScheme, .dark)
    }
}


public struct Tutorial6View: View {
    @Environment(ElectricGrid.self) private var grid
    public var body: some View {
        VStack(spacing: 0) {
            Text("Natural gas power plants require fuel to function. Make sure to keep fuel levels in sufficient levels for continuous operation.")
                .padding(24)
                .multilineTextAlignment(.center)
                .frame(width: 320, height: 140)
                .roundedRectangleGlass(cornerRadius: 16)
            HStack {
                Button {
                    grid.tutorialLevel = 5
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .yellow))
                Button {
                    grid.tutorialLevel = 7
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .green))
            }
            .padding(4)
            .padding(.horizontal, 4)
            .capsuleGlass()
            .offset(y: -20)
        }
        .environment(\.colorScheme, .dark)
    }
}


public struct Tutorial7View: View {
    @Environment(ElectricGrid.self) private var grid
    public var body: some View {
        VStack(spacing: 0) {
            Text("Power plants should be turned off from time to time for maintenance. If the maintenance level becomes zero, the power plant will turn off automatically.")
                .padding(24)
                .multilineTextAlignment(.center)
                .frame(width: 320, height: 160)
                .roundedRectangleGlass(cornerRadius: 16)
            HStack {
                Button {
                    grid.tutorialLevel = 6
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .yellow))
                Button {
                    grid.tutorialLevel = 8
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .green))
            }
            .padding(4)
            .padding(.horizontal, 4)
            .capsuleGlass()
            .offset(y: -20)
        }
        .environment(\.colorScheme, .dark)
    }
}


public struct Tutorial8View: View {
    @Environment(ElectricGrid.self) private var grid
    public var body: some View {
        VStack(spacing: 0) {
            Text("You can earn money from your customers. Your money can be used to purchase fuel or to build more power plants and customers.")
                .padding(24)
                .multilineTextAlignment(.center)
                .frame(width: 320, height: 140)
                .roundedRectangleGlass(cornerRadius: 16)
            HStack {
                Button {
                    grid.tutorialLevel = 7
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .yellow))
                Button {
                    grid.tutorialLevel = 9
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .green))
            }
            .padding(4)
            .padding(.horizontal, 4)
            .capsuleGlass()
            .offset(y: -20)
        }
        .environment(\.colorScheme, .dark)
    }
}


public struct Tutorial9View: View {
    @Environment(ElectricGrid.self) private var grid
    public var body: some View {
        VStack(spacing: 0) {
            Text("You can tap on an empty slot to build a power plant or customer. ")
                .padding(24)
                .multilineTextAlignment(.center)
                .frame(width: 300, height: 110)
                .roundedRectangleGlass(cornerRadius: 16)
            HStack {
                Button {
                    grid.tutorialLevel = 8
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .yellow))
                Button {
                    grid.tutorialLevel = 10
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .green))
            }
            .padding(4)
            .padding(.horizontal, 4)
            .capsuleGlass()
            .offset(y: -20)
        }
        .environment(\.colorScheme, .dark)
    }
}


public struct Tutorial10View: View {
    @Environment(ElectricGrid.self) private var grid
    public var body: some View {
        VStack(spacing: 0) {
            Text("This is your demand forecast. This allows you to see your demand for the next 12 hours so you can plan accordingly.")
                .padding(24)
                .multilineTextAlignment(.center)
                .frame(width: 300, height: 140)
                .roundedRectangleGlass(cornerRadius: 16)
            HStack {
                Button {
                    grid.tutorialLevel = 9
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .yellow))
                Button {
                    grid.tutorialLevel = 11
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .green))
            }
            .padding(4)
            .padding(.horizontal, 4)
            .capsuleGlass()
            .offset(y: -20)
        }
        .environment(\.colorScheme, .dark)
    }
}


public struct Tutorial11View: View {
    @Environment(ElectricGrid.self) private var grid
    public var body: some View {
        VStack(spacing: 0) {
            Text("These are the sunlight and wind forecasts. The power production of solar panels and wind turbines are dependent on the sunlight level and wind level, respectively.")
                .padding(24)
                .multilineTextAlignment(.center)
                .frame(width: 300, height: 160)
                .roundedRectangleGlass(cornerRadius: 16)
            HStack {
                Button {
                    grid.tutorialLevel = 10
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .yellow))
                Button {
                    grid.tutorialLevel = 12
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .green))
            }
            .padding(4)
            .padding(.horizontal, 4)
            .capsuleGlass()
            .offset(y: -20)
        }
        .environment(\.colorScheme, .dark)
    }
}


public struct Tutorial12View: View {
    @Environment(ElectricGrid.self) private var grid
    public var body: some View {
        VStack(spacing: 0) {
            Group {
                Text("You can tap the ")
                + Text("+1HR")
                    .font(.system(.body, design: .monospaced))
                + Text(" button to proceed to the next hour. Press the ")
                + Text(Image(systemName: "xmark"))
                + Text(" button to exit this tutorial.")
            }
            .multilineTextAlignment(.center)
            .padding(24)
            .frame(width: 300, height: 120)
            .roundedRectangleGlass(cornerRadius: 16)
            HStack {
                Button {
                    grid.tutorialLevel = 11
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .yellow))
                Button {
                    grid.tutorialLevel = 0
                    grid.tutorial = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                }
                .buttonStyle(CircleButtonStyle(color: .red))
            }
            .padding(4)
            .padding(.horizontal, 4)
            .capsuleGlass()
            .offset(y: -20)
        }
        .environment(\.colorScheme, .dark)
    }
}
