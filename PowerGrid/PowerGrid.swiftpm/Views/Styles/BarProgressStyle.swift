import SwiftUI

struct BarProgressStyle: ProgressViewStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        let progress = configuration.fractionCompleted ?? 0.0
        
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Capsule()
                    .fill(Color(uiColor: .systemGray5).opacity(0.25))
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        Capsule()
                            .fill(.tint)
                            .frame(width: geometry.size.width * progress)
                    }
            }
        }.frame(height: 6)
    }
}
