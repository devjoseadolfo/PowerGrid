import Foundation
import Charts
import SwiftUI

public protocol GridData: Identifiable {
    var date: Date { get }
    var amount: Int { get set }
}



