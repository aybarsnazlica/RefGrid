//
// DocumentsImageView.swift
// RefGrid
// https://www.github.com/aybarsnazlica/RefGrid
// See LICENSE for license information.
//

import SwiftUI

struct DocumentsImageView: View {
    var url: URL

    var body: some View {
        Image(uiImage: UIImage(contentsOfFile: url.path()) ?? .add)
            .resizable()
            .scaledToFit()
    }
}
