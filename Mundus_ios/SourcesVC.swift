//
//  SourcesVC.swift
//  Mundus_ios
//
//  Created by Stephan on 05/01/2017.
//  Copyright © 2017 Stephan. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class SourcesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var images = [SKPhoto]()
        let photo = SKPhoto.photoWithImage(UIImage(named: "file-page1")!)
        images.append(photo)
        
        // 2. create PhotoBrowser Instance, and present from your viewController.
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(0)
        self.navigationController?.pushViewController(browser, animated: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
