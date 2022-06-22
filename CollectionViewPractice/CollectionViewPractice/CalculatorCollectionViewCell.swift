//
//  CalculatorCollectionViewCell.swift
//  CollectionViewPractice
//
//  Created by zoho on 21/06/22.
//

import UIKit

class CalculatorCollectionViewCell: UICollectionViewCell {

    var cellView: UIView = {
        let cell = UIView()
        cell.backgroundColor = .white
        cell.layer.borderWidth = 0.2
        cell.layer.borderColor = UIColor.brown.cgColor
        return cell
    }()
    
    var cellLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 45, y: 45, width: 20, height: 20))
        label.textColor = .black
        label.setFont(.body)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellView.addSubview(cellLabel)
        cellView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height)
        contentView.addSubview(cellView)
  

    }
    
    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    func addLabel(_ type: [Calculator],_ indexPath: Int) {
        self.cellLabel.text = type[indexPath].value
    }
}



//cellValue.translatesAutoresizingMaskIntoConstraints = false
//cellValue.heightAnchor.constraint(equalTo: heightAnchor, constant: 5).isActive = true
//cellValue.widthAnchor.constraint(equalTo: widthAnchor, constant: 5).isActive = true
//cellValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
