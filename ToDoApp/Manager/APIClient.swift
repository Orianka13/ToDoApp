//
//  APIClient.swift
//  ToDoApp
//
//  Created by Олеся Егорова on 11.03.2022.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}


class APIClient {
    lazy var urlSession: URLSessionProtocol = URLSession.shared
    
    func login(withName name: String, password: String, completionHandler: @escaping (String?, Error?) -> Void) {
        
        let allowedCharacter = CharacterSet.urlQueryAllowed
        
        guard let name = name.addingPercentEncoding(withAllowedCharacters: allowedCharacter),
              let password = password.addingPercentEncoding(withAllowedCharacters: allowedCharacter)
        else { return }
        
        let query = "name=\(name)&password=\(password)"
        guard let url = URL(string: "https://todoapp.com/login?\(query)") else { return }
        urlSession.dataTask(with: url) { data, response, error in
            
        }.resume()
    }
}

extension URLSession: URLSessionProtocol {}
