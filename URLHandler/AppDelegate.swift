//
//  AppDelegate.swift
//  URLHandler
//
//  Created by 陈元兵 on 2020/3/12.
//  Copyright © 2020 陈元兵. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        RouterFactory.shared.register(ARouter())
        RouterFactory.shared.register(BRouter())
        return true
    }

}

