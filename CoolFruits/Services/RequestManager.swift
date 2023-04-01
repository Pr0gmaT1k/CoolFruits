//
//  RequestManager.swift
//  CoolFruits
//
//  Created by Luis Alejandro Zapata Gonzalez on 21-07-22.
//

import Foundation

class RequestManager {
    var session: URLSession
    var baseURL: String = "https://run.mocky.io/v3/d7a4fad5-4c51-453b-87ed-602d7a026872"
    
    public static let shared = RequestManager()
    
    init() {
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    public func getAllFruts(_ completion: @escaping (([FruitModel?]?, Error?) -> Void)) {
        session.dataTask(with: URL(string: baseURL + "/all")!) { data, response, error in
            if error != nil {
                completion(nil, error)
                return
            } else {
                do {
                    let decodedObject = try JSONDecoder().decode([FruitModel].self, from: data!)
                    completion(decodedObject, nil)
                } catch {
                    completion(nil, NSError())
                }
            }
        }.resume()
    }
}
