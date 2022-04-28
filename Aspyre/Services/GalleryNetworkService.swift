//
//  GalleryNetworkService.swift
//  Aspyre
//

import Moya
import CombineMoya
import Combine

protocol GalleryServiceType {
    func getAll(name: String, page: Int) -> AnyPublisher<PhotosResponse, Error>
    func getBy(id: String) -> AnyPublisher<DetailPhotoResponse, Error>
}

struct GalleryNetworkService: GalleryServiceType {
    
    private let api: MoyaProvider<GalleryApi>

    init(provider: MoyaProvider<GalleryApi>) {
        api = provider
    }
    
    func getAll(name: String, page: Int) -> AnyPublisher<PhotosResponse, Error> {
        api.requestPublisher(
            .search(
                name: name,
                page: page
            )
        )
    }
    
    func getBy(id: String) -> AnyPublisher<DetailPhotoResponse, Error> {
        api.requestPublisher(
            .photo(id: id)
        )
    }
}
