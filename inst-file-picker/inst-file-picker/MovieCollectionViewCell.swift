//
//  MovieCollectionViewCell.swift
//  inst-file-picker
//
//  Created by mitake on 2017/05/04.
//  Copyright © 2017 mitake. All rights reserved.
//

import UIKit
import Photos

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var thumImageView: UIImageView!
    var assets: PHAsset? = nil
    var isSelect: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setConfigure(assets: PHAsset) {
        let manager = PHImageManager()
        
        self.assets = assets
        
        self.selectedView.isHidden = !self.isSelected
        
        manager.requestImage(
            for: assets,
            targetSize: self.thumImageView.frame.size,
            contentMode: .aspectFill,
            options: nil,
            resultHandler: { [weak self] (image, info) in
                guard let wself = self, let _ = image else {
                    return
                }
                wself.thumImageView.image = image
        })
    }
    
    func select() -> Bool {
        if !self.isSelect {
            self.isSelected = true
            self.isSelect = self.isSelected
            self.selectedView.isHidden = !self.isSelected
        } else {
            self.deselect()
            self.isSelect = false
            self.isSelected = self.isSelect
        }
        return self.isSelect
    }
    
    func deselect() {
        self.isSelected = false
        self.isSelect = self.isSelected
        self.selectedView.isHidden = !self.isSelected
    }
}
