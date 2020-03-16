//
//  Router+transform.swift
//  URLHandler
//
//  Created by iAllenC on 2020/3/13.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit

extension UIViewController {
    public static var topViewController: UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while let presented = topController?.presentedViewController {
            topController = presented
        }
        return topController
    }
}

public protocol Transferable {
    static func push(_ viewController: UIViewController, animated: Bool)
    static func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
}

extension Transferable {
        
    public static func push(_ viewController: UIViewController, animated: Bool) {
        let topController = UIViewController.topViewController
        if let navi = topController as? UINavigationController {
            navi.pushViewController(viewController, animated: animated)
        } else if let tab = topController as? UITabBarController {
            let selectedController = tab.selectedViewController
            if let navi = selectedController as? UINavigationController {
                navi.pushViewController(viewController, animated: animated)
            } else {
                selectedController?.navigationController?.pushViewController(viewController, animated: animated)
            }
        }
    }
    
    public static func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        UIViewController.topViewController?.present(viewController, animated: animated, completion: completion)
    }

}

public struct Transfer: Transferable { }
