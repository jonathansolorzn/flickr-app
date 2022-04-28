//
//  Optional+Unwrap.swift
//  Aspyre
//

extension Optional {
    func unwrap<T>() -> T {
        guard let type = self as? T else { fatalError("Unable to unwrap \(T.self)") }
        return type
    }
}
