//
//  APIHandler.swift
//  CollegeList
//
//  Created by zoho on 06/07/22.
//

import Foundation

class APIHandler {
    
    func fetchquery(_ country: String?, completion: @escaping (([College])->Void)) {
        var url = Constants.Urls.collegesUrl
        guard let country = country?.replacingOccurrences(of: " ", with: "%20") else {
            return
        }
        url += "?country=\(country)"
        print(url)
        URLSession.shared.request(for: url, expecting: [College].self) { result in
            switch result {
            case .success(let responseData):
                let values = responseData
                completion(values)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCountryData(completion: @escaping ([String: Countries]?)->Void) {
        let url = Constants.Urls.countriesUrl
        URLSession.shared.request(for: url, expecting: Response.self) { result in
            switch result {
            case .success(let responseData):
                completion(responseData.data)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}
