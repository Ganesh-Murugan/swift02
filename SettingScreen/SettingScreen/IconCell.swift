//
//  IconCell.swift
//  SettingScreen
//
//  Created by zoho on 17/06/22.
//

import UIKit

class IconCell: UITableViewCell, Cell {
    
    var settingName = UILabel()
    var settingDescription = UILabel()
    var arrowIcon = UIImageView(image: UIImage(named: "chevron.png"))
    
    let screenHeight = UIScreen.main.bounds.height
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let contentWidth = contentView.bounds.width
        let contentHeight = contentView.bounds.height
        addFrame(contentWidth, contentHeight)
        contentView.addSubview(settingName)
        contentView.addSubview(settingDescription)
        contentView.addSubview(arrowIcon)
        settingName.body()
        settingDescription.caption()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addFrame(_ contentWidth: CGFloat, _ contentHeight: CGFloat) {
        arrowIcon.frame = CGRect(x: contentWidth + 45, y: 15, width: 35, height: 35)
        settingName.frame = CGRect(x: 15, y: contentHeight/2.8, width: contentWidth, height: 20)
        settingDescription.frame = CGRect(x: 15, y: contentHeight/1.1, width: contentWidth, height: 15)
    }
}




//extension IconCell {
//    func setNameConstraints() {
//        settingName.initialLabelSetup()
//        settingName.body()
//        settingName.setupAlignmentConstraints(centerXAnchor: nil, xAnchorConstant: 0, centerYAnchor: centerYAnchor, yAnchorConstant: -15)
//        settingName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        settingName.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        settingName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
//    }
//    func setDescriptionConstraints() {
//        settingDescription.initialLabelSetup()
//        settingDescription.caption()
//        settingDescription.setupAlignmentConstraints(centerXAnchor: nil, xAnchorConstant: 0, centerYAnchor: centerYAnchor, yAnchorConstant: 15)
//        settingDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        settingDescription.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        settingDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
//    }
//}
