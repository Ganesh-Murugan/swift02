//
//  SwitchCell.swift
//  SettingScreen
//
//  Created by zoho on 16/06/22.
//

import UIKit

class SwitchCell: UITableViewCell, Cell {
    var settingName = UILabel()
    var settingDescription = UILabel()
    var toggle = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addFrame(contentView.bounds.width, contentView.bounds.height)
        contentView.addSubview(settingName)
        contentView.addSubview(settingDescription)
        contentView.addSubview(toggle)
        settingName.body()
        settingDescription.caption()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addFrame(_ contentWidth: CGFloat, _ contentHeight: CGFloat) {
        toggle.frame = CGRect(x: contentWidth + 40, y: contentHeight/2, width: 35, height: 35)
        settingName.frame = CGRect(x: 15, y: contentHeight/2.5, width: contentWidth, height: 20)
        settingDescription.frame = CGRect(x: 15, y: contentHeight/1.3, width: contentWidth - 50, height: 55)
    }
    func toggled() {
        self.toggle.isOn ? self.toggle.setOn(false, animated: true) : self.toggle.setOn(true, animated: true)
    }
}


extension SwitchCell {
    func setNameConstraints() {
//        settingName.initialLabelSetup()
//        settingName.body()
//        settingName.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -15).isActive = true
//        settingName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        settingName.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        settingName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
    }
    func setDescriptionConstraints() {
//        settingDescription.initialLabelSetup()
//        settingDescription.caption()
//        settingDescription.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 15).isActive = true
//        settingDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        settingDescription.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        settingDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
    }
    
//    func setIconConstraints(){
//        toggle.translatesAutoresizingMaskIntoConstraints = false
//        toggle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        toggle.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 170).isActive = true
//    }
}
