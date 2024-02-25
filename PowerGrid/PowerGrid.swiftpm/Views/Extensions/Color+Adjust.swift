import SwiftUI

extension Color {
    public func adjust(by percentage: Double) -> Color {
        let resolvedColor = self.resolve(in: .init())
        
        return Color(red: Double(resolvedColor.red) + percentage,
                     green: Double(resolvedColor.green) + percentage,
                     blue: Double(resolvedColor.blue) + percentage,
                     opacity: Double(resolvedColor.opacity))
    }
    
}
