//
//  CollegesModel.swift
//  CollegeList
//
//  Created by zoho on 04/07/22.
//

import Foundation
protocol Data {
    
}


struct CollegeApiResponse: Decodable {
    var colleges: [College]?
}

struct College: Decodable, Data {
    var domains: [String]?
    var webPages: [String]?
    var name: String?
    var country: String?
    var alphaTwoCode: String?
}
