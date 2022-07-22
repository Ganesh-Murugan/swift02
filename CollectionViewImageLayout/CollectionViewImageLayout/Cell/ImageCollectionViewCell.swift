//
//  ImageCollectionViewCell.swift
//  CollectionViewImageLayout
//
//  Created by zoho on 21/07/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    func configure(_ catImages: UIImage) {
        imageView.image = catImages
    }
}
