//
//  ARouter.swift
//  Router
//
//  Created by iAllenC on 2020/3/13.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit

struct ARouter: Router {
    
    static var module: String { "moduleA" }
    
    init() {
        print("\(self)Inited!")
    }
            
    func subRouter(for module: String) -> Router? {
        switch module {
        case "moduleA_sub1":
            return ARouterOne()
        case "moduleA_sub2":
            return ARouterTwo()
        default:
            return nil
        }
    }
    
    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: ((RouteParameter) -> Void)?) {
        routeAfterSub(url, parameter: parameter, completion: completion) { (url, parameter, completion) in
            let avc = AViewController()
            avc.value = url.queryParameter?["value"]
            pushViewController(avc, animated: true)
            completion?(["result": avc])
        }
    }
    
    func fetch(_ url: URLConvertible, parameter: RouteParameter?, completion: ((RouteParameter) -> Void)?) -> Any? {
        fetchAfterSub(url, parameter: parameter, completion: completion) { (url, parameter, completion) -> Any? in
            let avc = AViewController()
            avc.value = url.queryParameter?["value"]
            completion?(["result": avc])
            return avc
        }
    }
}

struct ARouterOne: Router {
        
    static var module: String { "moduleA_sub1" }

    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: ((RouteParameter) -> Void)?) {
        let avc_sub1 = AViewControllerSubOne()
        pushViewController(avc_sub1, animated: true)
        completion?(["result": avc_sub1])
    }
    
}

struct ARouterTwo: Router {
    
    static var module: String { "moduleA_sub2" }

    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: ((RouteParameter) -> Void)?) {
        let avc_sub2 = AViewControllerSubTwo()
        pushViewController(avc_sub2, animated: true)
        completion?(["result": avc_sub2])
    }
    
}
