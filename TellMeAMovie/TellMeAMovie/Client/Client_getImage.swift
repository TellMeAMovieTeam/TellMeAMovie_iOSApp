//
//  Client_getImage.swift
//  TellMeAMovie
//
//  Created by Илья on 24.11.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import Foundation
import UIKit

public func setImageFromURL(url : String, imageView : UIImageView) {
    
    let url = URL(string: url)
    
    DispatchQueue.global().async {
        if let data = try? Data(contentsOf: url!) {
            //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            let imageView : UIImageView = imageView
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }
    }
    
}
