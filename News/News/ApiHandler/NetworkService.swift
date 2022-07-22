//
//  NetworkService.swift
//  News
//
//  Created by zoho on 15/07/22.
//

import Foundation


protocol URLProtocol {
    var url: URL { get }
    var path: String { get }
//    var httpMethod: HTTPMethod { get }
//    var task: HTTPTask { get }
//    var header: HTTPHeaders { get }
    func getcall()
}

extension URLProtocol {
     func getcall() {
        print("hi")
    }
}
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum HTTPTask {
    case request
    //case requestWith params
}
typealias HTTPHeaders = [String:String]

