//
//  ResumeCollectionViewLayout.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 13/2/2565 BE.
//

import Foundation
import UIKit

open class ResumeFlowLayout: UICollectionViewLayout {
    private enum Design {
        static let gap: CGFloat = 10
        static let itemRatio: CGFloat = 4/3
        static let column: CGFloat = 2
    }
    var itemWidth: CGFloat {
        return (UIScreen.main.bounds.width - (Design.gap * (Design.column + 1))) / Design.column
    }
    var itemHeight: CGFloat {
        return itemWidth * Design.itemRatio
    }
    
    private var cellAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    private var contentSize: CGSize = .zero
    override open func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        for section in 0..<collectionView.numberOfSections {
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let positionX = indexPath.row % Int(Design.column) == 0 ? Design.gap : (Design.gap * 2) + itemWidth
                let positionY = CGFloat(indexPath.row / Int(Design.column)) * (itemHeight + Design.gap)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
                cellAttributes[indexPath] = attributes
                contentSize = CGSize(width: UIScreen.main.bounds.width, height: Design.gap + attributes.frame.maxY)
            }
        }
    }
    
    open override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttributes.values.filter{ $0.frame.intersects(rect) }
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttributes[indexPath]
    }
}
