//
//  GalleryApi.swift
//  Aspyre
//

import Moya
import Foundation

enum GalleryApi {
    case search(name: String, page: Int)
    case photo(id: String)
}

extension GalleryApi: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: Constants.baseUrl) else {
            fatalError("baseURL could not be configurated.")
        }
        return url
    }
    
    var path: String {
        Endpoints.root
    }
    
    var method: Moya.Method {
        .get
    }

    var task: Task {
        
        switch self {
        case .search(let name, let page):
            return .requestParameters(
                parameters: [
                    Keys.method: Endpoints.searchPhotos,
                    Keys.apiKey: Constants.apiKey,
                    Keys.text: name,
                    Keys.page: page,
                    Keys.perPage: Constants.photosPerPage,
                    Keys.format: Constants.json,
                    Keys.nojsoncallback: 1
                ],
                encoding: URLEncoding.default
            )
            
        case .photo(let id):
            return .requestParameters(
                parameters: [
                    Keys.method: Endpoints.getPhotoDetail,
                    Keys.apiKey: Constants.apiKey,
                    Keys.photoId: id,
                    Keys.format: Constants.json,
                    Keys.nojsoncallback: 1
                ],
                encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String: String]? {
        ["Content-type": "application/json"]
    }
}
