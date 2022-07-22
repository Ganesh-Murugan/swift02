//
//  ViewController.swift
//  CollectionViewImageLayout
//
//  Created by zoho on 21/07/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var catImages = Cats.allCases
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.collectionViewLayout = CustomLayout()
        if let layout = collectionView.collectionViewLayout as? CustomLayout {
            layout.delegate = self
        }
        collectionView.delegate = self
        collectionView.dataSource = self
//        var layout: UICollectionViewFlowLayout = {
//            let layout = UICollectionViewFlowLayout()
//            layout.minimumLineSpacing = 5
//            layout.minimumInteritemSpacing = 10
//            layout.scrollDirection = .vertical
//            layout.itemSize = CGSize(width: 200, height: 300)
//            return layout
//        }()
    }
    
//    private func collectionViewLayout() -> UICollectionViewLayout {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(2), top: .fixed(2), trailing: .fixed(2), bottom: .fixed(2))
//        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/2))
//
////        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
//        let section = NSCollectionLayoutSection(group: group)
//
//        return UICollectionViewCompositionalLayout(section: section)
//    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, CustomLayoutDelegate {
    func height(_ collectionView: UICollectionView, forContentAt indexPath: IndexPath) -> CGFloat {
        catImages[indexPath.row].catImage.size.height
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        catImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.imageCollectionViewCellIdentifier, for: indexPath) as! ImageCollectionViewCell
        cell.configure(catImages[indexPath.row].catImage)
        return cell
    }    
}


