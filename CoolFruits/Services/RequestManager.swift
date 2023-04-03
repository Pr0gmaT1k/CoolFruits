//
//  RequestManager.swift
//  CoolFruits
//
//  Created by Luis Alejandro Zapata Gonzalez on 21-07-22.
//

import Foundation

extension String: Error {}

// MARK: - Class
class RequestManager {
    // MARK: - Properties
    var session: URLSession
    var baseURL: String = "https://run.mocky.io/v3/d7a4fad5-4c51-453b-87ed-602d7a026872"
    public static let shared = RequestManager()
    
    // MARK: - funcs
    init() {
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    public func getAllFruts(_ completion: @escaping (([FruitModel]?, Error?) -> Void)) {
        guard let url = URL(string: baseURL + "/all") else {
            completion(nil, "Incorrect URL")
            return
        }
        session.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(nil, error)
                return
            } else {
                do {
                    guard let data = data else {
                        completion(nil, "Data received is nil")
                        return
                    }
                    let decodedObject = try JSONDecoder().decode([FruitModel].self, from: data)
                    completion(decodedObject, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
