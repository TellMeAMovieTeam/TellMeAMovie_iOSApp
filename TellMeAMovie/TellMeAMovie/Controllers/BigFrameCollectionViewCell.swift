//
//  BigFrameCollectionViewCell.swift
//  TellMeAMovie
//
//  Created by Илья on 08.12.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import UIKit

import PureLayout

class BigFrameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frameImageView: UIImageView!
    
    public func frameInit(sringUrl : String) {
        
        self.frameImageView.sd_setImage(with: URL.init(string: sringUrl))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        frameImageView.autoMatch(.height, to: .width, of: self)
        frameImageView.autoMatch(.width, to: .height, of: self)
        frameImageView.autoCenterInSuperview()
        //frameImageView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2)) //90 degree//rotation in radians
        frameImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        frameImageView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0, 0, 1)
    }
    
}
