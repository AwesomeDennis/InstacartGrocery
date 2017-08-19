//
//  IGWebImage.swift
//  InstacartGrocery
//
//  Created by DingXiao on 2017/8/18.
//  Copyright © 2017年 AwesomeDennis. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView {
    public func setImage(urlString: String, placeHolder: UIImage?) {
        if let placeHolderImage = placeHolder {
            self.image = placeHolderImage
        }
        IGWebImageManager.shared.downloadImage(url: urlString) { (image, error) in
            if image != nil {
                self.image = image;
            }
        }
    }
}
