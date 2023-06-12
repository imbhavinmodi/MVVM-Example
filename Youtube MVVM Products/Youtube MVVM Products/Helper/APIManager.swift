//
//  APIManager.swift
//  Youtube MVVM Products
//
//  Created by Bhavin's on 07/06/23.
//

import UIKit

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

typealias Handler = (Result<[Product], DataError>) -> Void

// final -> we can not inherite the class by using final
final class APIManager {
    
    // Singleton Design Pattern
    static let shared = APIManager()
    
    private init() {}
    
    func fetchProduct(completion: @escaping Handler) {
        guard let url = URL(string: Constant.API.productURL) else {
            return
        }
        
        // Background task
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as?  HTTPURLResponse,
            200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            // Here, JSONDecoder() -> Convert data into array of model
            do {
                let product = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(product))
            }catch {
                completion(.failure(.network(error)))
            }
            
        }.resume()
    }
}

