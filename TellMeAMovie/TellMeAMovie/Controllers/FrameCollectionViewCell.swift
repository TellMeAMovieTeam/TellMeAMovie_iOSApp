//
//  FrameCollectionViewCell.swift
//  TellMeAMovie
//
//  Created by Илья on 30.11.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import UIKit
import SDWebImage

class FrameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frameImageView: UIImageView!
    
    public func frameInit(sringUrl : String) {
    
        self.frameImageView.sd_setImage(with: URL.init(string: sringUrl))
    }
    
}
