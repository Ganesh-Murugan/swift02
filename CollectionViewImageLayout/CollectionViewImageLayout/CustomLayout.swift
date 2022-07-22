//
//  CustomLayout.swift
//  CollectionViewImageLayout
//
//  Created by zoho on 21/07/22.
//

import UIKit
protocol CustomLayoutDelegate: AnyObject {
    func height(_ collectionView: UICollectionView, forContentAt indexPath: IndexPath) -> CGFloat
}
//extension CustomLayoutDelegate {
//    func height(_ collectionView: UICollectionView, forContentAt indexPath: IndexPath) -> CGFloat {
//        100
//    }
//
//}

class CustomLayout: UICollectionViewLayout {
    var cache: [UICollectionViewLayoutAttributes] = []
    weak var delegate: CustomLayoutDelegate?
    
    let numberOfColumns = 2
    let cellPadding: CGFloat = 12
    
    var contentHeight: CGFloat = 0
    var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else {
            return
        }
        let columnWidth = contentWidth / CGFloat(numberOfColumns)

        var xOffset = [CGFloat]()
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        var column = 0
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
        
            var imageHeight = delegate?.height(collectionView, forContentAt: indexPath) ?? 200

            if imageHeight > 500 {
                imageHeight = 500
            }
            let height = cellPadding * 2 + imageHeight

            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            print(yOffset[column])
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            
            attributes.frame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            cache.append(attributes)
            print(item ,frame.minY, frame.maxY, imageHeight)
            
//            print(contentHeight, imageHeight, height)
            contentHeight = max(contentHeight, frame.maxY)
//            print(contentHeight, frame.maxY)
            
            yOffset[column] = yOffset[column] + height
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
//            print(column)
        }
//        cache.forEach({print($0.frame)})
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attribute in cache {
//            print(attribute.frame)
            if attribute.frame.intersects(rect){
//                print(rect)
                visibleLayoutAttributes.append(attribute)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        cache[indexPath.item]
    }
}
