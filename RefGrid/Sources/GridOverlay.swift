//
// GridOverlay.swift
// RefGrid
// https://www.github.com/aybarsnazlica/RefGrid
// See LICENSE for license information.
//

import SwiftUI

struct GridOverlay: View {
  let rows: Int
  let columns: Int
  var lineWidth: CGFloat = 1
  var color: Color = .white.opacity(0.7)

  var body: some View {
    Canvas { context, size in
      let w = size.width
      let h = size.height
      let rowStep = h / CGFloat(max(rows, 1))
      let colStep = w / CGFloat(max(columns, 1))

      var path = Path()

      // Vertical lines
      for c in 1..<columns {
        let x = CGFloat(c) * colStep
        path.move(to: CGPoint(x: x, y: 0))
        path.addLine(to: CGPoint(x: x, y: h))
      }

      // Horizontal lines
      for r in 1..<rows {
        let y = CGFloat(r) * rowStep
        path.move(to: CGPoint(x: 0, y: y))
        path.addLine(to: CGPoint(x: w, y: y))
      }

      context.stroke(path, with: .color(color), lineWidth: lineWidth)
    }
    .allowsHitTesting(false)
  }
}
