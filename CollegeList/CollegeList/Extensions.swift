//
//  Extension.swift
//  CollegeList
//
//  Created by zoho on 02/07/22.
//

import Foundation

extension URLSession {
    enum CustomError: Error{
        case invalidUrl, invalidData
    }
    func request<T: Decodable>(for urlString: String,
                               expecting: T.Type,
                               completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        let task = dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                
                let object = try decoder.decode(expecting, from: data)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
