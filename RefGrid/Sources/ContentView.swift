//
// ContentView.swift
// RefGrid
// https://www.github.com/aybarsnazlica/RefGrid
// See LICENSE for license information.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedAlbum = [Album]()

    @Query var albums: [Album]

    var body: some View {
        NavigationStack(path: $selectedAlbum) {
            List {
                ForEach(albums) { album in
                    NavigationLink(value: album) {
                        Text("\(album.name) (\(album.photos.count))")
                    }
                }
                .onDelete(perform: deleteAlbum)
            }
            .contentMargins(.top, 20, for: .scrollContent)
            .navigationTitle("RefGrid")
            .navigationDestination(for: Album.self, destination: AlbumEditor.init)
            .toolbar {
                Button("Add new album", systemImage: "plus", action: createNewAlbum)
            }
        }
    }

    func createNewAlbum() {
        let newAlbum = Album(name: "New album", photos: [], duration: 10)
        modelContext.insert(newAlbum)
        try? modelContext.save()
        selectedAlbum = [newAlbum]
    }

    func deleteAlbum(_ indexSet: IndexSet) {
        for item in indexSet {
            let album = albums[item]
            modelContext.delete(album)
        }
    }
}

#Preview {
    ContentView()
}
