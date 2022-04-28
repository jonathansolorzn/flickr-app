//
//  GalleryViewModel.swift
//  Aspyre
//

import Foundation
import Combine

final class GalleryViewModel: ObservableObject {
    
    // MARK: - Declarations
    
    @Published private(set) var photos: [Photo] = []
    @Published private(set) var showEmptyState = false
    @Published var searchContactName = Constants.empty
    
    private let galleryService: GalleryServiceType
    private var cancellable = Set<AnyCancellable>()
    private var page = Constants.initialPage
    private var totalPages = Constants.zero
    
    // MARK: - Init/Deinit
    
    init(galleryService: GalleryServiceType) {
        self.galleryService = galleryService
        setSearchPublisher()
    }
    
    // MARK: - Public Methods
    
    func reload() {
        page = Constants.initialPage
        photos.removeAll()
        searchPhotos()
    }
    
    func areMorePhotosAvailable() -> Bool {
        (page + 1) <= totalPages
    }
    
    func loadMorePhotos() {
        page += 1
        searchPhotos()
    }
    
    // MARK: - Helpers
    
    private func setSearchPublisher() {
        $searchContactName
            .debounce(
                for: .milliseconds(Constants.delayToSearchPhotos),
                scheduler: RunLoop.main
            )
            .removeDuplicates()
            .map { [weak self] (string) -> String? in

                if string.isEmpty {
                    self?.photos.removeAll()
                  return nil
                }
                  
                return string
            }
            .compactMap { $0 }
            .sink { (_) in
            } receiveValue: { [weak self] (_) in
                self?.reload()
            }
            .store(in: &cancellable)
    }
    
    private func searchPhotos() {
        galleryService
            .getAll(
                name: searchContactName,
                page: page
            )
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] response in
                    
                    let items = response.result.photos
                    
                    self?.showEmptyState = items.isEmpty
                    self?.photos += items
                    self?.totalPages = response.result.pages
                }
            )
            .store(in: &cancellable)
    }
}

extension GalleryViewModel {
    static func make() -> GalleryViewModel {
        GalleryViewModel(galleryService: Injector.resolve(GalleryServiceType.self))
    }
}
