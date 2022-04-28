//
//  PhotosResponse.swift
//  Aspyre
//

// MARK: - PhotosResponse
struct PhotosResponse: Codable {
    let result: Photos
    
    private enum CodingKeys: String, CodingKey {
        case result = "photos"
    }
}

// MARK: - Photos
struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photos: [Photo]
    
    private enum CodingKeys: String, CodingKey {
        case page, pages, perpage, total
        case photos = "photo"
    }
}

// MARK: - Photo
struct Photo: Codable, Identifiable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    
    func getSmallImage() -> String {
        getPath(size: "n")
    }
    
    func getMediumImage() -> String {
        getPath(size: "z")
    }
    
    private func getPath(size: String) -> String {
        "https://live.staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg"
    }
}
