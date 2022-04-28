//
//  DetailView.swift
//  Flickr
//

import SwiftUI
import Kingfisher
import SkeletonUI

struct DetailView: View {
    
    @StateObject var viewModel: DetailViewModel = .make()
    
    var id: String
    var photo: String?
    
    var body: some View {
        
        GeometryReader { geometry in
        
            ZStack(alignment: .bottomLeading) {
                
                let imageURL = URL(string: photo ?? Constants.empty)
                
                KFImage(imageURL)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .accessibilityIdentifier(Constants.detailImageIdentifier)
                
                VStack(alignment: .leading) {
                
                    let isOwnerNil = viewModel.owner == nil
                    
                    Button(L10n.openInBrowser) {
                        if let url = URL(string: photo ?? Constants.empty),
                           UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }
                    .padding(5)
                    .background(Color.gray.opacity(Constants.colorOpacity))
                    .clipShape(Rectangle())
                    .cornerRadius(Constants.generalCornerRadius)
                    .accessibilityIdentifier(Constants.detailBrowserButtonIdentifier)
                    
                    Text("\(L10n.owener) \(viewModel.owner?.name ?? Constants.empty)")
                        .skeleton(
                            with: isOwnerNil,
                            size: CGSize(
                                width: geometry.size.width,
                                height: Constants.galleryTextSkelentonHeight
                            )
                        )
                        .lineLimit(Constants.oneLineLimit)
                        .accessibilityIdentifier(Constants.detailOwnerTextIdentifier)
                    
                    Text("\(L10n.takenAt) \(viewModel.owner?.date ?? Constants.empty)")
                        .skeleton(
                            with: isOwnerNil,
                            size: CGSize(
                                width: geometry.size.width,
                                height: Constants.galleryTextSkelentonHeight
                            )
                        )
                        .lineLimit(Constants.oneLineLimit)
                        .accessibilityIdentifier(Constants.detailDateTextIdentifier)
                    
                    Text(viewModel.owner?.description)
                        .skeleton(
                            with: isOwnerNil,
                            size: CGSize(
                                width: geometry.size.width,
                                height: Constants.galleryTextSkelentonHeight
                            )
                        )
                        .lineLimit(3)
                        .accessibilityIdentifier(Constants.detailDescriptionTextIdentifier)
                }
                .padding()
                .frame(width: geometry.size.width, alignment: .leading)
                .background(Color.black.opacity(Constants.colorOpacity))
                .foregroundColor(.white)
                .font(.footnote)
            }
        }
        .onAppear {
            viewModel.getPhotoDetail(id: id)
        }
        .navigationBarTitle(L10n.appName, displayMode: .inline)
    }
}
