//
//  SourcesVC.swift
//  Mundus_ios
//
//  Created by Stephan on 05/01/2017.
//  Copyright © 2017 Stephan. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class SourcesVC: UICollectionViewController, SKPhotoBrowserDelegate {

    private let numberOfItemsPerRow : CGFloat = 3.0
    private let padding : CGFloat = 8.0
    private let amountImg :Int = 30
    private var browser = SKPhotoBrowser()

    var images = [SKPhoto]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = (UIScreen.main.bounds.width - padding) / numberOfItemsPerRow
        let layout = collectionViewLayout as!UICollectionViewFlowLayout
        self.collectionView!.backgroundView = UIImageView(image: UIImage(named: "lightwood"))
        layout.itemSize = CGSize(width: width  * sqrt(2.0), height: width)
        let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsetsMake(self.tabBarController!.tabBar.frame.height, 0, 0, 0);
        edgesForExtendedLayout = []
        self.tabBarController!.tabBar.backgroundColor = UIColor.white
        extendedLayoutIncludesOpaqueBars = true;
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        tabBarItem = UITabBarItem(title: "Sources", image: UIImage(named: "sources"), tag: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        for index in 1...amountImg {
            let photo = SKPhoto.photoWithImage(UIImage(named: "file-page\(index)")!)
            images.append(photo)
        }
        // 2. create PhotoBrowser Instance, and present from your viewController.
        browser = SKPhotoBrowser(photos: images)
        SKPhotoBrowserOptions.displayAction = false
        browser.delegate = self

    }

    override func numberOfSections(`in` collectionView: UICollectionView) -> Int {
        return 1
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amountImg
    }

    private struct Storyboard
    {
        static let CellIdentifier = "imagecell"
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as! ImgCell
        cell.imgg = UIImage(named: "file-page\(indexPath.item + 1)")
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        browser.initializePageIndex(indexPath.item)
        self.present(browser, animated: true, completion: {})
    }


}
