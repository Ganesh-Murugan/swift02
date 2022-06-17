//
//  ext.swift
//  SettingScreen
//
//  Created by zoho on 16/06/22.
//

import Foundation
import UIKit

extension UILabel {
    func initialLabelSetup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.adjustsFontSizeToFitWidth = true
    }
    func caption() {
        self.font = .monospacedSystemFont(ofSize: 15, weight: .bold)
        self.textColor = .gray
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
    }
    
    func body() {
        self.font = .systemFont(ofSize: 18)
        
    }
    
    func setupAlignmentConstraints(centerXAnchor: NSLayoutXAxisAnchor?, xAnchorConstant: CGFloat, centerYAnchor: NSLayoutYAxisAnchor?, yAnchorConstant: CGFloat) {
        if let centerXAnchor = centerXAnchor {
            self.centerXAnchor.constraint(equalTo: centerXAnchor, constant: xAnchorConstant).isActive = true
        }
        if let centerYAnchor = centerYAnchor {
            self.centerYAnchor.constraint(equalTo: centerYAnchor, constant: yAnchorConstant).isActive = true
        }
    }
    func setupConstraints(){
        
    }
}

extension Cell {
    func addCell(_ index: Settings){
        self.settingName.text = index.settingName
        self.settingDescription.text = index.settingDescription
    }
}
