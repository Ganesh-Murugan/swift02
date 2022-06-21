//
//  CalculatorCollectionViewCell.swift
//  CollectionViewPractice
//
//  Created by zoho on 21/06/22.
//

import UIKit

class CalculatorCollectionViewCell: UICollectionViewCell {

    var cellValue: UIButton = {
        let cell = UIButton()
        cell.backgroundColor = .white
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.titleLabel?.textAlignment = .center
        cell.setTitleColor(.black, for: .normal)
        return cell
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellValue.frame = CGRect(x: 10, y: 10, width: contentView.bounds.width, height: contentView.bounds.height)
        contentView.addSubview(cellValue)
  

    }
    
    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
}



//cellValue.translatesAutoresizingMaskIntoConstraints = false
//cellValue.heightAnchor.constraint(equalTo: heightAnchor, constant: 5).isActive = true
//cellValue.widthAnchor.constraint(equalTo: widthAnchor, constant: 5).isActive = true
//cellValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
