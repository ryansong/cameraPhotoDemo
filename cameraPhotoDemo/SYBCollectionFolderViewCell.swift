//
//  SYBCollectionFolderViewCell.swift
//  cameraPhotoDemo
//
//  Created by Ryan on 5/8/17.
//  Copyright © 2017 Song Xiaoming. All rights reserved.
//

import UIKit

class SYBCollectionFolderViewCell: UICollectionViewCell {
    let textLabel:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initSubViews()
    }
    
    func initSubViews() {
        self.addSubview(self.textLabel)
        self.textLabel.textColor = UIColor.black
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel.sizeToFit()
        self.textLabel.center = self.center
    }
}
