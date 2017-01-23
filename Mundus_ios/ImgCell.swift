//
//  ImgCell.swift
//  Mundus_ios
//
//  Created by Stephan on 09/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//

import UIKit

class ImgCell: UICollectionViewCell {

    @IBOutlet weak var sourceImageView: UIImageView!

    var image: UIImage? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        sourceImageView.image = image
    }

}
