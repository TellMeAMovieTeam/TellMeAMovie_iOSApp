//
//  FramesCollectionViewController.swift
//  TellMeAMovie
//
//  Created by Илья on 02.12.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FramesCollectionViewController: UICollectionViewController {

    private var frameNumber : Int = 0
    public var currentSelectedMovie : Movie = Movie.init()
    let longSideModifyer : Float = 16.0
    let shortSideModifyer : Float = 9.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frameNumber = (currentSelectedMovie.framesURLs.count - 1)
        collectionView?.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frameNumber
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FrameCollectionViewCell
        cell.frameImageView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2)); //90 degree//rotation in radians

        if (currentSelectedMovie.framesURLs.count != 0) {
            
            cell.prepareForReuse()
            
            cell.frameInit(sringUrl: currentSelectedMovie.framesURLs[indexPath.item].value)
            
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth : Float = Float(self.view.frame.size.width)
        let cellHeight : Float = roundf((cellWidth / shortSideModifyer) * longSideModifyer)
        
        return CGSize.init(width: CGFloat(cellWidth), height: CGFloat(cellHeight))
        
    }
    
}