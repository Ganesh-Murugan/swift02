//
//  SwitchCell.swift
//  SettingScreen
//
//  Created by zoho on 16/06/22.
//

import UIKit

class SwitchCell: UITableViewCell {
    var settingName = UILabel()
    var settingDescription = UILabel()
    //var icon = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(settingName)
        contentView.addSubview(settingDescription)
        setNameConstraints()
        setDescriptionConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNameConstraints() {
        settingName.setUpLabelConstraints()
        settingName.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive = true
        settingName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        settingName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        settingName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
    }
    func setDescriptionConstraints() {
        settingDescription.setUpLabelConstraints()
        settingDescription.textColor = .gray
        settingDescription.font = .monospacedSystemFont(ofSize: 15, weight: .bold)
        settingDescription.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive = true
        settingDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        settingDescription.heightAnchor.constraint(equalToConstant: 20).isActive = true
        settingDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
    }
    func addCell(_ index: Settings){
        self.settingName.text = index.settingName
        self.settingDescription.text = index.settingDescription
    }
}

extension UILabel {
    func setUpLabelConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.adjustsFontSizeToFitWidth = true
        
    }
}
