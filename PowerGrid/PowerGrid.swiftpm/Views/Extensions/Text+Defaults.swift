import SwiftUI

extension Text {
    public func titleTextStyle() -> Text {
        self.font(.system(size: 18, weight: .bold))
    }
    
    public func bodyTextStyle() -> Text {
        self.font(.system(size: 16, weight: .regular))
            .foregroundStyle(.white.opacity(0.9))
    }
    
    public func captionTextStyle() -> Text {
        self.font(.system(size: 12, weight: .regular))
            .foregroundStyle(.white.opacity(0.75))
    }
    
    public func buttonTextStyle() -> Text {
        self.font(.system(size: 16, weight: .bold))
    }
    
    public func barTextStyle() -> Text {
        self.font(.system(size: 12, design: .monospaced))
    }
}
