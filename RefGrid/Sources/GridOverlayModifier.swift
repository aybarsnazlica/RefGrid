//
// GridOverlayModifier.swift
// RefGrid
// https://www.github.com/aybarsnazlica/RefGrid
// See LICENSE for license information.
//

import SwiftUI

extension View {
    func gridOverlay(
        rows: Int, columns: Int, lineWidth: CGFloat = 1, color: Color = .white.opacity(0.7)
    ) -> some View {
        overlay(
            GridOverlay(rows: rows, columns: columns, lineWidth: lineWidth, color: color)
        )
    }
}
