//
//  Router+transform.swift
//  URLHandler
//
//  Created by iAllenC on 2020/3/13.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit

extension Router {
    public var topViewController: UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while let presented = topController?.presentedViewController {
            topController = presented
        }
        return topController
    }
    
    public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let topController = topViewController
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
    
    public func presentViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        let topController = topViewController?.navigationController?.topViewController ?? topViewController
        topController?.present(viewController, animated: animated, completion: completion)
    }
}
