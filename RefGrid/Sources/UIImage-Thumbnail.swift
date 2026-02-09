//
// UIImage-Thumbnail.swift
// RefGrid
// https://www.github.com/aybarsnazlica/RefGrid
// See LICENSE for license information.
//

import UIKit

extension UIImage {
    func createThumbnail(at size: CGSize) -> Data? {
        let aspectWidth = size.width / self.size.width
        let aspectHeight = size.height / self.size.height
        let aspectRatio = max(aspectWidth, aspectHeight)

        let targetSize = CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio)
        let origin = CGPoint(x: (size.width - targetSize.width) / 2, y: (size.height - targetSize.height) / 2)

        let renderer = UIGraphicsImageRenderer(size: size)

        return renderer.jpegData(withCompressionQuality: 0.5) { _ in
            draw(in: CGRect(origin: origin, size: targetSize))
        }
    }
}
