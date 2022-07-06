//
//  CountryTableViewCell.swift
//  CollegeList
//
//  Created by zoho on 02/07/22.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    var countryLabel : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 10, width: 400, height: 15)
        label.textAlignment = .left
        return label
    }()
    
    var regionLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 15, width: 400, height: 15)
        return label
    }()
    
//    var stackView : UIStackView = {
//        let stackView = UIStackView()
//        stackView.alignment = .leading
//        return stackView
//    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.bounds.size.width = UIScreen.main.bounds.width
//        stackView.addSubview(label)
        
        contentView.addSubview(regionLabel)
        contentView.addSubview(countryLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    func add(_ country: Countries) {
        self.countryLabel.text = country.country
        self.regionLabel.text = "region: " + country.region.unwrap
    }
}
