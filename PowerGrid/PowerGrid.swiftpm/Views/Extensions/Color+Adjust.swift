import SwiftUI

extension Color {
    public func adjust(by percentage: Double) -> Color {
        let resolvedColor = self.resolve(in: .init())
        
        return Color(red: Double(resolvedColor.red) + percentage,
                     green: Double(resolvedColor.green) + percentage,
                     blue: Double(resolvedColor.blue) + percentage,
                     opacity: Double(resolvedColor.opacity))
    }
    
    func getComponents() -> (red: Double, green: Double, blue: Double, alpha: Double) {
        let resolvedColor = self.resolve(in: .init())
        return (Double(resolvedColor.red),
                Double(resolvedColor.green),
                Double(resolvedColor.blue),
                Double(resolvedColor.opacity))
    }
    
}
