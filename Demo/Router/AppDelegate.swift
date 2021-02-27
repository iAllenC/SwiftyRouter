//
//  AppDelegate.swift
//  RouterDemo
//
//  Created by Dsee.Lab on 2020/3/14.
//  Copyright © 2020 Dsee.Lab. All rights reserved.
//

import UIKit
import SwiftyURLRouter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        SchemeFactory.shared.register(scheme: "router") {
            ARouter.self
            BRouter.self
            CRouter.self
            ToolRouter.self
        }
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let scheme = url.scheme, scheme == "router" {
            Route(url).route()
        }
        return true
    }

}

