//
//  AppDelegate.swift
//  RouterDemo
//
//  Created by Dsee.Lab on 2020/3/14.
//  Copyright © 2020 Dsee.Lab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        RouterFactory.shared.register(ARouter())
        RouterFactory.shared.register(BRouter())
        RouterFactory.shared.register(CRouter())
        RouterFactory.shared.register(ToolRouter())
        return true
    }


}

