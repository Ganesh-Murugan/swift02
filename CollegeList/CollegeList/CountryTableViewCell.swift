//
//  CountryTableViewCell.swift
//  CollegeList
//
//  Created by zoho on 02/07/22.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    var label : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 10, width: 200, height: 20)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.bounds.size.width = UIScreen.main.bounds.width
        contentView.addSubview(label)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    func add(_ country: Countries) {
        self.label.text = country.country
    }
}
