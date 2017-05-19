//
//  SYBCollectionViewLineLayout.swift
//  cameraPhotoDemo
//
//  Created by Ryan on 5/4/17.
//  Copyright © 2017 Song Xiaoming. All rights reserved.
//

import UIKit

let ItemWidth = UIScreen.main.bounds.width

class SYBCollectionViewLineLayout: UICollectionViewLayout {

    var height:CGFloat = 0.0;
    var items:[UICollectionViewLayoutAttributes] = Array()
    
    override open var collectionViewContentSize: CGSize {
        get {
            var s:CGSize = CGSize.zero
            s.width = (self.collectionView?.bounds.width)!
            s.height = self.height * CGFloat((self.collectionView?.numberOfItems(inSection: 0))!)
            return s
        }
    }
    
    override func prepare() {
        self.items.removeAll()
        
        var y:CGFloat = 0;
        
        let sectionCount:Int = (self.collectionView?.numberOfSections)!
        for section in 0..<sectionCount {
            let rowCount:Int = (self.collectionView?.numberOfItems(inSection: section))!
            for row in 0..<rowCount {
                let indexPath = IndexPath.init(row: row, section: section)
                let layout = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
                layout.frame = CGRect.init(x: 0, y: y, width: ItemWidth, height: self.height)
                
                self.items.append(layout)
                y += (layout.frame.size.height)
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var array:[UICollectionViewLayoutAttributes] = Array()
        
        for layout in self.items {
            if (layout.frame.intersects(rect)) {
                array.append(layout)
            }
        }
     
        return array;
    }

    
}
