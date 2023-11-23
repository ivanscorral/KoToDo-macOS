//
//  UserEndpointHandler.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 5/11/23.
//

import Foundation

// Implement handling of user endpoints

struct NewUserResult: Codable {
    var message: String
    var data: CodableUser?
}

class UserEndpointHandler {
    
    let baseURL = "http://127.0.0.1:3000"
    
    func newUser(user: NewUserPayload, completion: @escaping (NewUserResult?, Error?) -> Void) {
        let url = URL(string: baseURL + APIEndpoint.newUser.info.path)!
        var request = URLRequest(url: url)
        
        // Set HTTP method and headers
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encode and set the JSON body
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
        } catch {
            completion(nil, error)
            return
        }
        
        // Send the request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(nil, APIError.requestFailed)
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    // Adjust the date format to match your response
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)

                    let decoded = try decoder.decode(NewUserResult.self, from: data)
                    completion(decoded, nil)
                } catch {
                    print("Decoding error: \(error)")
                    completion(nil, APIError.decodingError)
                }
            }

        }
        
        task.resume()
    }

}
