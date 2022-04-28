//
//  ServiceAssembly.swift
//  Flickr
//

import Swinject
import SwinjectAutoregistration
import Moya

public struct ServiceAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(MoyaProvider<GalleryApi>.self) { _ in
            MoyaProvider<GalleryApi>()
        }
        container.autoregister(GalleryServiceType.self, initializer: GalleryNetworkService.init)
    }
}
