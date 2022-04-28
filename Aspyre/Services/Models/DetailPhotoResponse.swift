//
//  DetailPhotoResponse.swift
//  Aspyre
//

// MARK: - DetailPhotoResponse
struct DetailPhotoResponse: Codable {
    let photo: DetailPhoto
}

// MARK: - DetailPhoto
struct DetailPhoto: Codable {
    let id: String
    let owner: Owner?
    let title: Description
    let description: Description
    let dates: Dates
}

// MARK: - Dates
struct Dates: Codable {
    let posted: String
    let taken: String
}

// MARK: - Owner
struct Owner: Codable {
    let nsid: String
    let username: String
    let realname: String
    let location: String?
}

// MARK: - Description
struct Description: Codable {
    let content: String

    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
}
