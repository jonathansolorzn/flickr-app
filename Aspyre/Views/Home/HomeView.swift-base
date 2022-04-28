//
//  HomeView.swift
//  Aspyre
//
//  Created by Byron Solorzano on 9/4/22.
//

import SwiftUI
import Kingfisher
import SwiftUIContactPicker

struct HomeView: View {
    
    @State var selectedContact: PhoneContact?
    @State var selectedPhoto: SectionPhoto?
    @State var searchContactName: String = Constants.empty
    @State var isContactSheetOpened: Bool = false
    @State var isTappedSearch: Bool = false
    
    private var contactPickerViewModel = ContactPickerViewModel(store: ContactStore())

    var body: some View {
        NavigationView {
            VStack {
                Text(L10n.accessToContacts)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                SearchBar(
                    searchText: $searchContactName,
                    onTapSearch: {
                        if !searchContactName.isEmpty {
                            isTappedSearch.toggle()
                        }
                    },
                    onTapContact: {
                        isContactSheetOpened.toggle()
                    }
                )
                .sheet(isPresented: $isContactSheetOpened, content: {
                    ContactListView(
                        viewModel: contactPickerViewModel,
                        selectedContact: $selectedContact,
                        onCancel: {
                            isContactSheetOpened = false
                        })
                })
                .onChange(of: selectedContact) { _ in
                    isContactSheetOpened = false
                    searchContactName = selectedContact?.givenName ?? Constants.empty
                    selectedPhoto = nil
                }
                NavigationLink(
                    Constants.empty,
                    destination: GalleryView(
                        selectedPhoto: $selectedPhoto,
                        nameContact: searchContactName
                    ),
                    isActive: $isTappedSearch
                )
                Spacer()
                KFImage(URL(string: selectedPhoto?.smallImage ?? Constants.empty))
                    .resizable()
                    .scaledToFill()
                    .background(Color(.lightGray))
                    .frame(width: Constants.homePhotoSize, height: Constants.homePhotoSize)
                    .padding()
                    .clipped()
                    .onTapGesture {
                        if let url = URL(
                            string: selectedPhoto?.mediumImage ?? Constants.empty
                        ), UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }
                Spacer()
            }
            .navigationBarTitle(L10n.appName, displayMode: .inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
