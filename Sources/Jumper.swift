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
    
    public static var rootViewcontroller: UIViewController? {
        UIApplication.shared.keyWindow?.rootViewController
    }
    
    public var currentNavi: UINavigationController? {
        if let navi = self as? UINavigationController {
            return navi
        } else if let tab = self as? UITabBarController {
            let selectedController = tab.selectedViewController
            if let navi = selectedController as? UINavigationController {
                return navi
            } else {
                return selectedController?.navigationController
            }
        } else {
            return navigationController
        }
    }
}

public protocol Jumpable {
    static var jumper: UIViewController? { get }
    static func push(_ viewController: UIViewController, animated: Bool)
    static func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
}

extension Jumpable {
    
    public static func push(_ viewController: UIViewController, animated: Bool) {
        jumper?.currentNavi?.pushViewController(viewController, animated: animated)
    }

    public static func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        jumper?.present(viewController, animated: animated, completion: completion)
    }

}


/// 基于当前顶部VC进行跳转
public struct TopJumper: Jumpable {
    
    public static var jumper: UIViewController? { UIViewController.topViewController }
    
}

/// 基于当前rootVC进行跳转
public struct RootJumper: Jumpable {
    
    public static var jumper: UIViewController? { UIViewController.rootViewcontroller }
    
}
