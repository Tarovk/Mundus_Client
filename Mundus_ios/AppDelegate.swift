//
//  AppDelegate.swift
//  Mundus_ios
//
//  Created by Stephan on 19/12/2016.
//  Copyright © 2016 Stephan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isShowingSources: Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        forcePortraitOrientation()
        return true
    }

    func forcePortraitOrientation() {
        let orientation = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(orientation, forKey: "orientation")
    }

    func forceLandscapeOrientation() {
        let orientation = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(orientation, forKey: "orientation")
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor
        window: UIWindow?) -> UIInterfaceOrientationMask {
        return isShowingSources ? UIInterfaceOrientationMask.landscapeLeft : UIInterfaceOrientationMask.portrait
    }

}
