import Foundation

extension Date {
    func makeDateString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM dd")
        return dateFormatter.string(from: self)
    }
    
    func makeTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        return dateFormatter.string(from: self)
    }
}
