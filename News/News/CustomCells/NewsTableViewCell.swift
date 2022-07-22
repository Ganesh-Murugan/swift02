//
//  NewsTableViewCell.swift
//  News
//
//  Created by zoho on 13/07/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var source: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title.setContentHuggingPriority(UILayoutPriority(rawValue: 900), for: .vertical)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupLoaderCells() {
        title.backgroundColor = .gray
        newsDescription.backgroundColor = .gray
        source.backgroundColor = .gray
        newsImage.backgroundColor = .gray
    }
    func setupCell(_ article: Article) {
        title.text = article.title
        newsDescription.text = article.description
        source.text = article.source?.name
        newsImage.loadImage(article.urlToImage.unwrap)
//        ImageCache().loadImage(article.urlToImage.unwrap)
    }
    
}
