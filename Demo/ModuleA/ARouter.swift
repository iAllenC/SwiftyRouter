//
//  ARouter.swift
//  Router
//
//  Created by iAllenC on 2020/3/13.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit
import SwiftyURLRouter

//MARK: First level router

struct ARouter: Router {
    
    static var module: String { "module_a" }

    static func subRouterType(for module: String) -> Router.Type? {
        switch module {
        case ARouterOne.module:
            return ARouterOne.self
        case ARouterTwo.module:
            return ARouterTwo.self
        default:
            return nil
        }
    }
    
    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {
        let avc = AViewController()
        avc.value = url.queryParameter?["value"]
        RootJumper.push(avc, animated: true)
        completion?(["result": avc])
    }
    
    func fetch(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) -> Any? {
        let avc = AViewController()
        avc.value = url.queryParameter?["value"]
        completion?(["result": avc])
        return avc
    }
}

//MARK: Second level router

struct ARouterOne: Router {
    
    static var module: String { "module_a_sub1" }
    
    static func subRouterType(for module: String) -> Router.Type? {
        return module == ARouterOneOne.module ? ARouterOneOne.self : nil
    }

    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {
        let avc_sub1 = AViewControllerSubOne()
        avc_sub1.passedValue = url.queryParameter?["value"]
        RootJumper.push(avc_sub1, animated: true)
        completion?(["result": avc_sub1])
    }
    
}

struct ARouterTwo: Router {
    
    static var module: String { "module_a_sub2" }

    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {
        let avc_sub2 = AViewControllerSubTwo()
        RootJumper.push(avc_sub2, animated: true)
        completion?(["result": avc_sub2])
    }
    
}

//MARK: Third level router

struct ARouterOneOne: Router {
        
    static var module: String { "module_a_sub1_sub1" }
    
    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {
        let alert = UIAlertController(title: "Alert", message: "This is a third level layer", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        UIViewController.topViewController?.present(alert, animated: true) {
            completion?(["result": true])
        }
    }
}
