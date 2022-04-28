//
//  SearchBar.swift
//  Flickr
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    
    var onTapSearch: () -> Void
    var onTapContact: () -> Void
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(.white)
            
            HStack {
                
                Image(systemName: "person.crop.square.fill")
                    .onTapGesture(perform: onTapContact)
                
                ZStack(alignment: .leading) {
                    if searchText.isEmpty {
                        Text(L10n.search)
                            .accessibilityIdentifier(Constants.searchViewTextIdentifier)
                    }
                    TextField(Constants.empty, text: $searchText)
                        .onSubmit {
                            onTapSearch()
                        }
                        .submitLabel(.done)
                        .accessibilityIdentifier(Constants.searchViewTextFieldIdentifier)
                }
                
                Image(systemName: "magnifyingglass")
                    .accessibilityIdentifier(Constants.searchViewButtonIdentifier)
                    .onTapGesture(perform: onTapSearch)
            }
            .foregroundColor(.black)
            .padding(Constants.searchBarPadding)
        }
        .frame(height: Constants.searchBarHeight)
        .cornerRadius(Constants.generalCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.generalCornerRadius)
                .stroke(.black, lineWidth: 1)
        )
        .padding()
    }
}
