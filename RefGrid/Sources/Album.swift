//
// Album.swift
// RefGrid
// https://www.github.com/aybarsnazlica/RefGrid
// See LICENSE for license information.
//

import SwiftData

@Model
class Album {
  var name: String
  var photos: [String]
  var duration: Int

  init(name: String, photos: [String], duration: Int) {
    self.name = name
    self.photos = photos
    self.duration = duration
  }
}
