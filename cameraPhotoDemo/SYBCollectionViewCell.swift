//
//  SYBCollectionViewCell.swift
//  cameraPhotoDemo
//
//  Created by Ryan on 5/2/17.
//  Copyright © 2017 Song Xiaoming. All rights reserved.
//

import UIKit

class SYBCollectionViewCell: UICollectionViewCell {
    
    let imageView:UIImageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView.frame = self.bounds
    }
        
    func setupCell(model:SYBImageAssetModel) -> Void {
        self.imageView.image = model.image
        if (model.image == nil
            && model.imageAsset != nil) {
             model.image = model.imageAsset?.image(with: self.traitCollection)
            self.imageView.image = model.image
        }
    }
    
    override func prepareForReuse() {
        self.imageView.image = nil;
    }
}
