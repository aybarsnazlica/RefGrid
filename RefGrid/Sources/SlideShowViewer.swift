//
// SlideShowViewer.swift
// RefGrid
// https://www.github.com/aybarsnazlica/RefGrid
// See LICENSE for license information.
//

import SwiftUI

struct SlideshowViewer: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentImageIndex = 0
    @State private var isZoomed = false
    var album: Album

    var body: some View {
        Button {
            dismiss()
        } label: {
            ZStack {
                DocumentsImageView(url: album.photos[currentImageIndex].documentsURL).gridOverlay(rows: 3, columns: 3)
            }
            
        }
        .ignoresSafeArea()
        .statusBarHidden()
        .background(.black)
        .task {
            changeSlide()
        }
    }

    func changeSlide() {
        withAnimation(.linear(duration: Double(album.duration))) {
            isZoomed.toggle()
        }

        Task {
            try await Task.sleep(for: .seconds(album.duration))

            withAnimation(.easeInOut(duration: 1)) {
                currentImageIndex = (currentImageIndex + 1) % album.photos.count
            }

            changeSlide()
        }
    }
}
