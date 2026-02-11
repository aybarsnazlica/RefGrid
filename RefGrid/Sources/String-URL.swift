//
// String-URL.swift
// RefGrid
// https://www.github.com/aybarsnazlica/RefGrid
// See LICENSE for license information.
//

import Foundation

extension String {
    var documentsURL: URL {
        URL.documentsDirectory.appending(path: self)
    }

    var thumbnailURL: URL {
        URL.documentsDirectory.appending(path: "\(self)-thumbnail")
    }
}
