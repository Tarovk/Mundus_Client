//
//  SourcesVC.swift
//  Mundus_ios
//
//  Created by Team Aldo on 05/01/2017.
//  Copyright © 2017 Team Aldo. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class SourcesVC: UICollectionViewController, SKPhotoBrowserDelegate {

    private let numberOfItemsPerRow: CGFloat = 3.0
    private let padding: CGFloat = 8.0
    private let sourcesCount: Int = 30
    private var browser = SKPhotoBrowser()

    var images = [SKPhoto]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let width = (UIScreen.main.bounds.width - padding) / numberOfItemsPerRow
        let layout = collectionViewLayout as!UICollectionViewFlowLayout
        self.collectionView!.backgroundView = UIImageView(image: UIImage(named: "lightwood"))
        layout.itemSize = CGSize(width: width  * sqrt(2.0), height: width)

        edgesForExtendedLayout = []
        self.tabBarController!.tabBar.backgroundColor = UIColor.white
        extendedLayoutIncludesOpaqueBars = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        tabBarItem = UITabBarItem(title: "Sources", image: UIImage(named: "sources"), tag: 1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        for index in 1...sourcesCount {
            let image = UIImage(named: "file-page\(index)")!
            let photo = SKPhoto.photoWithImage(image)

            images.append(photo)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        browser = SKPhotoBrowser(photos: images)
        SKPhotoBrowserOptions.displayAction = false
        browser.delegate = self
    }

    override func numberOfSections(`in` collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourcesCount
    }

    private struct Storyboard {
        static let CellIdentifier = "imagecell"
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as! ImgCell

        cell.image = images[indexPath.item].underlyingImage
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.isShowingSources = true

        browser.initializePageIndex(indexPath.item)
        UIViewController.attemptRotationToDeviceOrientation()

        self.present(browser, animated: true, completion: {
            appDelegate.forceLandscapeOrientation()
            UIViewController.attemptRotationToDeviceOrientation()
        })
    }

    func willDismissAtPageIndex(_ index: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.isShowingSources = false
        appDelegate.forcePortraitOrientation()
        UIViewController.attemptRotationToDeviceOrientation()
    }

}
