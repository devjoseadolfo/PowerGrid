import SwiftUI

struct ComponentInfoBodyView: View {
    var title: String
    var titleValue: String
    var subtitle: String?
    var subtitleValue: String?
    
    var currentValue: Double?
    var totalValue: Double?
  
    init(title: String,
         titleValue: String,
         subtitle: String? = nil,
         subtitleValue: String? = nil,
         currentValue: Double? = nil,
         totalValue: Double? = nil) {
        self.title = title
        self.titleValue = titleValue
        self.subtitle = subtitle
        self.subtitleValue = subtitleValue
        self.currentValue = currentValue
        self.totalValue = totalValue
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title + " ")
                .bodyTextStyle()
            + Text(titleValue)
                .bodyTextStyle()
                .monospaced()
            if let subtitle = subtitle,
               let subtitleValue = subtitleValue {
                Text(subtitle + " ")
                    .captionTextStyle()
                + Text(subtitleValue)
                    .captionTextStyle()
                    .monospaced()
            }
            if let currentValue = currentValue,
               let totalValue = totalValue {
                ProgressView(value: currentValue, total: totalValue)
                    .progressViewStyle(BarProgressStyle())
                    .animation(.easeIn, value: currentValue)
            }
        }
        
    }
}
