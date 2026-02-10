//
// RefGridApp.swift
// RefGrid
// https://www.github.com/aybarsnazlica/RefGrid
// See LICENSE for license information.
//

import SwiftData
import SwiftUI

@main
struct RefGridApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(for: Album.self)
  }
}
