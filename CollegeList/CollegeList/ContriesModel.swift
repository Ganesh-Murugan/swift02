//
//  ContriesModel.swift
//  CollegeList
//
//  Created by zoho on 02/07/22.
//

import Foundation

struct Response: Decodable {
    var status: String?
    var version: String?
    var access: String?
    var data: [String : Countries]? = nil
}

struct Countries: Decodable, Data {
    var country: String?
    var region: String?
}
