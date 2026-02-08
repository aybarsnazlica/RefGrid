import SwiftUI
import UIKit

private struct KeepScreenOnModifier: ViewModifier {
    let enabled: Bool

    func body(content: Content) -> some View {
        content
            .onAppear {
                if enabled {
                    UIApplication.shared.isIdleTimerDisabled = true
                }
            }
            .onDisappear {
                // Only re-enable if we were the ones disabling it
                if enabled {
                    UIApplication.shared.isIdleTimerDisabled = false
                }
            }
    }
}

public extension View {
    /// Prevents the device from dimming and locking automatically while this view is visible.
    /// - Parameter when: Pass `true` to keep the screen on; `false` to leave system behavior unchanged.
    func keepScreenOn(when: Bool) -> some View {
        modifier(KeepScreenOnModifier(enabled: `when`))
    }
}
