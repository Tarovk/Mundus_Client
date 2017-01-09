//
//  ImgCell.swift
//  Mundus_ios
//
//  Created by Stephan on 09/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//

import UIKit

class ImgCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!

    var imgg: UIImage? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        img.image = imgg
    }

}
