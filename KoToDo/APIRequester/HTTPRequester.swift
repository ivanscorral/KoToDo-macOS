//
//  HTTPRequester.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 4/11/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingError
}

class HTTPRequester {
    
    let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func request<T: Decodable>(
        endpoint: APIEndpoint,
        body: Data? = nil,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        let (path, method) = endpoint.info
        guard let url = URL(string: baseURL + path) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error)
                completion(.failure(.requestFailed))
                return
            } else if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                } catch {
                    print(error)
                    completion(.failure(.decodingError))
                }
            }
        }
    }
    
}
