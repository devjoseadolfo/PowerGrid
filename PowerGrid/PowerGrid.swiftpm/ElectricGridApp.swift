import SwiftUI

@main
struct ElectricGridApp: App {
    @State private var grid = ElectricGrid(rowCount: 5, columnCount: 5)
    
    @State private var gameOver: Bool = false
    
    var state: Bool { gameOver || grid.newGame || grid.cellToDelete != nil || grid.sufficientFundsError || grid.showOnboarding}
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                MainView()
                    .environment(grid)
                    .preferredColorScheme(.light)
                    .onChange(of: grid.hearts) {
                        if grid.hearts == 0 {
                            gameOver = true
                        }
                    }
                    .frame(minWidth: 1200, minHeight: 900)
                    .ignoresSafeArea()
                    .grayscale(state ? 1.0 : 0)
                    .disabled(state)
                HStack {
                    if gameOver {
                        AlertView(title: "Game Over",
                                  message: "You have lost all 5 hearts. Do you want to start a new game?",
                                  actionName: "New Game",
                                  action: {
                            grid = ElectricGrid(rowCount: 5, columnCount: 5)
                            gameOver = false
                        },
                                  buttonColor: .green)
                    }
                    if grid.newGame {
                        AlertView(title: "Confirm",
                                  message: "Do you want to start a new game?",
                                  actionName: "New Game",
                                  action: {
                            grid = ElectricGrid(rowCount: 5, columnCount: 5)
                            grid.newGame = false
                        },
                                  buttonColor: .green,
                                  secondaryActionName: "Cancel",
                                  secondaryAction: {
                                        grid.newGame = false
                        },
                                  secondaryButtonColor: .init(white: 0.6))
                    }
                    if let cell = grid.cellToDelete {
                        AlertView(title: "Confirm",
                                  message: "Do you want to delete \(cell.component?.name ?? "")?",
                                  actionName: "Delete",
                                  action: {
                            grid.removeComponent(at: cell.index)
                            grid.cellToDelete = nil
                        },
                                  buttonColor: .red,
                                  secondaryActionName: "Cancel",
                                  secondaryAction: {
                            grid.cellToDelete = nil
                        },
                                  secondaryButtonColor: .init(white: 0.6))
                    }
                    if grid.sufficientFundsError {
                        AlertView(title: "Insufficient Funds",
                                  message: "Your current balance $" + grid.money.makeString() + " is not enough to pay your total running cost $" + grid.calculateTotalRunningCost().makeString() + ". Consider shutting down some power plants to reduce your total running cost.",
                                  actionName: "Back",
                                  action: {
                            grid.sufficientFundsError = false
                        },
                                  buttonColor: .init(white: 0.6))
                    }
                    if grid.showOnboarding {
                        OnboardingView()
                            .environment(grid)
                    }
                }
            }
            .animation(.easeIn.speed(0.75), value: state)
            .animation(.easeIn, value: grid.showOnboarding)
            .animation(nil, value: grid.tutorialLevel)
            .withHostingWindow { window in
                       #if targetEnvironment(macCatalyst)
                       if let titlebar = window?.windowScene?.titlebar {
                           titlebar.titleVisibility = .hidden
                           titlebar.toolbar = nil
                       }
                       #endif
                   }
            .persistentSystemOverlays(.hidden)
        }
        .windowResizability(.contentMinSize)
    }
}
