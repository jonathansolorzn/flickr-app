//
//  ContactPicker.swift
//  Aspyre
//

import SwiftUI
import ContactsUI
import Contacts

protocol ContactPickerViewControllerDelegate: AnyObject {
    func contactPickerViewControllerDidCancel(_ viewController: ContactPickerViewController)
    func contactPickerViewController(_ viewController: ContactPickerViewController, didSelect contact: CNContact)
}

class ContactPickerViewController: UIViewController, CNContactPickerDelegate {
    weak var delegate: ContactPickerViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.open(animated: animated)
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        self.dismiss(animated: false) {
            self.delegate?.contactPickerViewControllerDidCancel(self)
        }
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        self.dismiss(animated: false) {
            self.delegate?.contactPickerViewController(self, didSelect: contact)
        }
    }
    
    private func open(animated: Bool) {
        let viewController = CNContactPickerViewController()
        viewController.delegate = self
        self.present(viewController, animated: false)
    }
}

struct ContactPicker: UIViewControllerRepresentable {
    
    @Binding var contactSelected: String
    var dismiss: () -> Void
    
    final class Coordinator: NSObject, ContactPickerViewControllerDelegate {
        
        var parent: ContactPicker

        init(_ parent: ContactPicker) {
            self.parent = parent
        }
        
        func contactPickerViewController(_ viewController: ContactPickerViewController, didSelect contact: CNContact) {
            parent.contactSelected = contact.givenName
            parent.dismiss()
        }
        
        func contactPickerViewControllerDidCancel(_ viewController: ContactPickerViewController) {
            viewController.dismiss(animated: false)
            parent.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ContactPicker>) -> ContactPicker.UIViewControllerType {
        let result = ContactPicker.UIViewControllerType()
        result.delegate = context.coordinator
        return result
    }
    
    func updateUIViewController(_ uiViewController: ContactPicker.UIViewControllerType, context: UIViewControllerRepresentableContext<ContactPicker>) { }
    
    typealias UIViewControllerType = ContactPickerViewController
}
