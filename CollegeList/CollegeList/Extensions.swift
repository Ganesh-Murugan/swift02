//
//  Extension.swift
//  CollegeList
//
//  Created by zoho on 02/07/22.
//

import Foundation
enum HttpMethods: String {
    case post = "POST", get = "GET"
}

enum CustomError: Error{
    case invalidUrl, invalidData
}
extension URLSession {
    func request<T: Decodable>(for urlString: String,
                               expecting: T.Type, httpMethod: HttpMethods? = .get,
                               params: [String:String]? = [:],
                               completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
//        print(url)
//        var request = URLRequest(url: url)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = httpMethod?.rawValue
//
//        guard let param = params  else {
//            return
//        }
//
//        let body = try? JSONSerialization.data(withJSONObject: param)
//
//        request.httpBody = body
        
        let task = dataTask(with: url) { (data, response, error) in
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

extension Optional where Wrapped == String {
    var unwrap: String {
        self ?? ""
    }
}
extension Optional where Wrapped == Int {
    var unwrap: Int {
        self ?? 0
    }
}

extension String{
    mutating func customTrim(){
//        for var element in self {
            let openingBracket = self.firstIndex(of: "(")
            let closingBracket = self.firstIndex(of: ")")
            if let openingBracket = openingBracket, let closingBracket = closingBracket {
                self = String(self.prefix(upTo: openingBracket) + self.suffix(from: closingBracket))
            }
//        }
    }
}


//extension Array where Element == Countries {
//    func customTrim(){
//        for var element in self {
//            let openingBracket = element.country?.firstIndex(of: "(")
//            let closingBracket = element.country?.firstIndex(of: ")")
//            if let openingBracket = openingBracket, let closingBracket = closingBracket {
//                element.country = String(element.country.unwrap.prefix(upTo: openingBracket) + element.country.unwrap.prefix(upTo: closingBracket))
//            }
//        }
//    }
//}
