//
//  extensions.swift
//  Practice
//
//  Created by zoho on 10/06/22.
//

import Foundation

extension Int {
    var toString: String  {
        String(self)
    }
}

extension Optional where Wrapped == String {
    var unwrap: String {
        guard let self = self else { return "unknown" }
        return self
    }
}

extension Array where Element: Equatable {
    func searchFilter(searchText: String) -> [Contacts] {
        return contactList.filter { searchText.isEmpty || (($0.name.unwrap).localizedStandardContains(searchText)) ||
            (($0.number?.toString).unwrap).localizedStandardContains(searchText)                                    }
    }
    
    func sort<T: Comparable>(_ property: (Element) -> T) -> [Element] {
        return sorted(by: {property($0) < property($1)})
    }
}
extension Array {
    func unique(_ selector:(Element,Element)->Bool) -> Array<Element> {
        return reduce(Array<Element>()){
            if let last = $0.last {
                return selector(last,$1) ? $0 : $0 + [$1]
            } else {
                return [$1]
            }
        }
    }
}
