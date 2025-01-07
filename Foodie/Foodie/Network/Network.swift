//
//  Network.swift
//  Foodie
//
//  Created by heyji on 1/7/25.
//

import Foundation

class Network {
    static let shared = Network()
    
    private let baseURL = "http://52.231.51.93:8000"
    private let getRestaurantURL = "/restaurants/search/"
    
    private init() { }
    
    func getRestaurants(query: String, completion: @escaping (Restaurant) -> Void) {
        let urlString = baseURL + getRestaurantURL + query
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        guard var urlComponents = URLComponents(string: urlString) else { return }
        
        guard let requestURL = urlComponents.url else { return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: requestURL) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Restaurant.self, from: data)
                completion(response)
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
        
//        guard let url = URL(string: urlString) else {
//            completion(.failure(NetworkError.invalidURL))
//            return
//        }
    }
}
