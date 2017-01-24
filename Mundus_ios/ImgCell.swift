//
//  ImgCell.swift
//  Mundus_ios
//
//  Created by Team Aldo on 09/01/2017.
//  Copyright (c) 2017 Team Aldo. All rights reserved.
//

import UIKit

/// ViewCell for the sources panel.
class ImgCell: UICollectionViewCell {

    @IBOutlet weak var sourceImageView: UIImageView!

    var image: UIImage? {
        didSet {
            updateUI()
        }
    }

    /// Sets the image of the ViewCell.
    func updateUI() {
        sourceImageView.image = image
    }

}
