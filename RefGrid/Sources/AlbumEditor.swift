//
// AlbumEditor.swift
// RefGrid
// https://www.github.com/aybarsnazlica/RefGrid
// See LICENSE for license information.
//

import PhotosUI
import SwiftUI
import SwiftData

struct AlbumEditor: View {
    @State private var selectedItems = [PhotosPickerItem]()
    @Environment(\.modelContext) private var modelContext
    @State private var slideshowAlbum: Album?
    @Bindable var album: Album

    let gridItems: [GridItem] = [.init(.adaptive(minimum: 100, maximum: 100))]

    var body: some View {
        Form {
            Section {
                Picker("Duration", selection: $album.duration) {
                    Text("10 minutes").tag(60*10)
                    Text("5 minutes").tag(60*5)
                    Text("2 minutes").tag(60*2)
                    Text("60 seconds").tag(60)
                    Text("30 seconds").tag(30)

                    #if DEBUG
                    Text("3 seconds").tag(3)
                    #endif
                }
            }

            LazyVGrid(columns: gridItems) {
                ForEach(album.photos, id: \.self) { photo in
                    Menu {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            album.photos.removeAll { element in
                                element == photo
                            }

                            try? modelContext.save()
                        }
                    } label: {
                        DocumentsImageView(url: photo.thumbnailURL)
                            .frame(width: 100, height: 100)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
            }
            .listRowBackground(Color.clear)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle($album.name)
        .toolbar {
            PhotosPicker(selection: $selectedItems, matching: .images) {
                Label("Select images", systemImage: "photo.badge.plus")
            }

            if album.photos.isEmpty == false {
                Button("Start slideshow", systemImage: "play") {
                    slideshowAlbum = album
                }
                .symbolVariant(.fill)
            }
        }
        .fullScreenCover(item: $slideshowAlbum, content: SlideshowViewer.init)
        .onChange(of: selectedItems) {
            Task {
                for item in selectedItems {
                    guard let imageData = try? await item.loadTransferable(type: Data.self) else { continue }
                    guard let uiImage = UIImage(data: imageData) else { continue }
                    guard let imageThumbnailData = uiImage.createThumbnail(at: CGSize(width: 100, height: 100)) else { continue }

                    let imageID = UUID().uuidString

                    do {
                        try imageData.write(to: imageID.documentsURL)
                        try imageThumbnailData.write(to: imageID.thumbnailURL)
                        album.photos.append(imageID)
                    } catch {
                        print("Failed to write image to \(imageID.documentsURL): \(error.localizedDescription)")
                    }
                }

                selectedItems.removeAll()
                try? modelContext.save()
            }
        }
    }
}

#Preview {
    AlbumEditor(album: Album(name: "Preview Album", photos: [], duration: 10))
}
