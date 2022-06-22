//
//  extensions.swift
//  CollectionViewPractice
//
//  Created by zoho on 21/06/22.
//

import Foundation
import UIKit

extension Int {
    var toString: String  {
        String(self)
    }
    
}
extension String {
    var toInt: Int {
        Int(self) ?? 0
    }
    func filterNum() -> String {
        return self.filter{ "0123456789".contains($0)}
    }
    
}

extension Array where Element == Int {
    var toString: [String] {
        return self.map({$0.toString})
    }
}
enum FontSet {
    case caption, body
}
extension UILabel {
    
    func setFont(_ fontSet: FontSet) {
        switch fontSet{
        case .caption:
            self.font = .monospacedSystemFont(ofSize: 15, weight: .bold)
            self.textColor = .gray
            self.lineBreakMode = .byWordWrapping
            self.numberOfLines = 0
        case .body:
            self.font = .systemFont(ofSize: 18)
        }
    }
}

