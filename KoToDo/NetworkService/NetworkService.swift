//
//  NetworkService.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 9/11/23.
//

import Foundation


struct ApiResponse<T: Codable>: Codable {
    var message: String
    var data: T
}
struct ApiConfig {
    static let baseURL = "http://127.0.0.1:3000"
}

enum ApiError: Error {
    case httpError(statusCode: Int, message: String)
    case decodingError(message: String)
    case unknownError(Error)
}

struct ApiErrorResponse: Codable {
    var code: Int
    var error: String
}

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func request<T: Codable, V: Codable>(
        endpoint: Endpoint,
        headers: [String: String]?,
        body: T?,
        completion: @escaping (Result<ApiResponse<V>, ApiError>) -> Void
    ) {
        let url = URL(string: "\(ApiConfig.baseURL)\(endpoint.path)")!
        print(" URL: \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        
        // Set additional headers if provided
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Encode the body, if provided
        if let body = body {
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(body)
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                completion(.failure(.decodingError(message: "Could not encode body")))
                return
            }
        }
        
        // Check the status code after performing the request
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(.unknownError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.httpError(statusCode: 0, message: "Non-HTTP response received")))
                return
            }
            
            switch httpResponse.statusCode {
            case 200..<300:
                // Successful request, decode the response
                guard let data = data else {
                    completion(.failure(.decodingError(message: "No data received")))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let apiResponse = try decoder.decode(ApiResponse<V>.self, from: data)
                    completion(.success(apiResponse ))
                } catch {
                    print(error)
                    completion(.failure(.decodingError(message: "Could not decode response")))
                }
            case 400..<600:
                // Error response, decode the error
                guard let data = data else {
                    completion(.failure(.decodingError(message: "HTTP error without body")))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let apiErrorResponse = try decoder.decode(ApiErrorResponse.self, from: data)
                    completion(.failure(.httpError(statusCode: httpResponse.statusCode, message: apiErrorResponse.error)))
                }  catch {
                    completion(.failure(.decodingError(message: "Could not decode error response")))
                }
            default:
                completion(.failure(.httpError(statusCode: httpResponse.statusCode, message: "Unexpected status code [\(httpResponse.statusCode)] received")))
            }
        }

            
            task.resume()
    }
    
}
