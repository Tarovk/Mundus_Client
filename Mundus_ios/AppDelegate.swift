//
//  AppDelegate.swift
//  Mundus_ios
//
//  Created by Stephan on 19/12/2016.
//  Copyright © 2016 Stephan. All rights reserved.
//

import UIKit
import Aldo

/**
    Singleton containing methods that are called in the lifetime of the app.
 */
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isShowingSources: Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        forcePortraitOrientation()
        return true
    }

    /// Forces the device to set the orientation to portrait.
    func forcePortraitOrientation() {
        let orientation = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(orientation, forKey: "orientation")
    }

    /// Forces the device to set the orientation to landscape.
    func forceLandscapeOrientation() {
        let orientation = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(orientation, forKey: "orientation")
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor
        window: UIWindow?) -> UIInterfaceOrientationMask {
        return isShowingSources ? UIInterfaceOrientationMask.landscapeLeft : UIInterfaceOrientationMask.portrait
    }

    /// Clears all information about a stored session.
    class func clearSessionData() {
        Aldo.getStorage().removeObject(forKey: Aldo.Keys.SESSION.rawValue)
    }

}
