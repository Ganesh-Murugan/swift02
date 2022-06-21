//
//  extensions.swift
//  CollectionViewPractice
//
//  Created by zoho on 21/06/22.
//

import Foundation

extension Int {
    var toString: String  {
        String(self)
    }
}

extension Array where Element == Int {
    var toString: [String] {
        return self.map({$0.toString})
    }
}
