//
//  Constants.swift
//  CollectionViewImageLayout
//
//  Created by zoho on 21/07/22.
//

import Foundation
import UIKit
struct Constants {
    struct Identifiers {
        static let imageCollectionViewCellIdentifier = "imageCollectionViewCellIdentifier"
    }
}

enum Cats: String, CaseIterable {
    case cat1 = "cat1"
    case cat2 = "cat2"
    case cat3 = "cat3"
    case cat4 = "cat4"
    case cat5 = "cat5"
    case cat6 = "cat6"
    case cat7 = "cat7"
    case cat8 = "cat8"
    case cat9 = "cat9"
    case cat10 = "cat10"
    case cat11 = "cat11"
    case cat12 = "cat12"
    case cat13 = "cat13"
    case cat14 = "cat14"
    
    var catImage: UIImage! {
        switch self {
        case .cat1:
            return UIImage(named: Cats.cat1.rawValue)
        case .cat2:
            return UIImage(named: Cats.cat2.rawValue)
        case .cat3:
            return UIImage(named: Cats.cat3.rawValue)
        case .cat4:
            return UIImage(named: Cats.cat4.rawValue)
        case .cat5:
            return UIImage(named: Cats.cat5.rawValue)
        case .cat6:
            return UIImage(named: Cats.cat6.rawValue)
        case .cat7:
            return UIImage(named: Cats.cat7.rawValue)
        case .cat8:
            return UIImage(named: Cats.cat8.rawValue)
        case .cat9:
            return UIImage(named: Cats.cat9.rawValue)
        case .cat10:
            return UIImage(named: Cats.cat10.rawValue)
        case .cat11:
            return UIImage(named: Cats.cat11.rawValue)
        case .cat12:
            return UIImage(named: Cats.cat12.rawValue)
        case .cat13:
            return UIImage(named: Cats.cat13.rawValue)
        case .cat14:
            return UIImage(named: Cats.cat14.rawValue)
        }
    }
}
