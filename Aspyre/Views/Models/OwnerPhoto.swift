//
//  OwnerPhoto.swift
//  Aspyre
//

import Foundation

struct OwnerPhoto: Identifiable {
    let id = UUID()
    let name: String
    let date: String
    let description: String
    
    init(from detail: DetailPhotoResponse) {
        name = detail.photo.owner?.realname ?? Constants.empty
        date = detail.photo.dates.taken
        description = detail.photo.description.content
    }
}
