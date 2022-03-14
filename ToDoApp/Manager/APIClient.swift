//
//  APIClient.swift
//  ToDoApp
//
//  Created by Олеся Егорова on 11.03.2022.
//

import Foundation

enum NetworkError: Error {
    case emptyData
}

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
            
            guard error == nil else {
                return completionHandler(nil, error)
            }
            
            do {
                guard let data = data else {
                    completionHandler(nil, NetworkError.emptyData)
                    return
                }
                let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : String]
                let token = dictionary?["token"]
                completionHandler(token, nil)
            } catch {
                completionHandler(nil, error)
            }
        }.resume()
    }
}

extension URLSession: URLSessionProtocol {}
