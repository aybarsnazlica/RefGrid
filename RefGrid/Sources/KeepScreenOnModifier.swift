//
// KeepScreenOnModifier.swift
// RefGrid
// https://www.github.com/aybarsnazlica/RefGrid
// See LICENSE for license information.
//

import SwiftUI
import UIKit

private struct KeepScreenOnModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .onAppear {
        UIApplication.shared.isIdleTimerDisabled = true
      }
      .onDisappear {
        UIApplication.shared.isIdleTimerDisabled = false
      }
  }
}

extension View {
  public func keepScreenOn() -> some View {
    modifier(KeepScreenOnModifier())
  }
}
