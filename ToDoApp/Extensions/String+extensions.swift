//
//  String+extensions.swift
//  ToDoApp
//
//  Created by Олеся Егорова on 11.03.2022.
//

import Foundation

extension String {
    var percentEncoded: String {
        let allowedCharacters = CharacterSet(charactersIn: "!@#$%^&*()_+-=~`/\\").inverted
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else { fatalError() }
        return encodedString
    }
}
