//
//  ARouter.swift
//  URLRouter
//
//  Created by iAllenC on 2020/3/13.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit

class ARouter: URLRouter {
    
    var module: String = "moduleA"
        
    var subRouters: [String : URLRouter]? = ["moduleA_sub1": ARouterOne(), "moduleA_sub2": ARouterTwo()]
    
    func route(_ url: URLConvertible, parameter: [String: Any]?, completion: (([String: Any]) -> Void)?) {
        if let subRouter = subRouter(url) {
            return subRouter.route(url, parameter: parameter, completion: completion)
        }
        let avc = AViewController()
        avc.value = url.queryParameter?["value"]
        pushViewController(avc, animated: true)
        completion?(["result": avc])
    }
    
    func fetch(_ url: URLConvertible, parameter: [String : Any]?, completion: (([String : Any]) -> Void)?) -> UIViewController? {
        if let subRouter = subRouter(url) {
            return subRouter.fetch(url, parameter: parameter, completion: completion)
        }
        let avc = AViewController()
        avc.value = url.queryParameter?["value"]
        completion?(["result": avc])
        return avc
    }
}

class ARouterOne: URLRouter {
        
    var module: String = "moduleA_sub1"

    func route(_ url: URLConvertible, parameter: [String : Any]?, completion: (([String : Any]) -> Void)?) {
        let avc_sub1 = AViewControllerSubOne()
        pushViewController(avc_sub1, animated: true)
        completion?(["result": avc_sub1])
    }
    
}

class ARouterTwo: URLRouter {
    
    var module: String = "moduleA_sub2"

    func route(_ url: URLConvertible, parameter: [String : Any]?, completion: (([String : Any]) -> Void)?) {
        let avc_sub2 = AViewControllerSubTwo()
        pushViewController(avc_sub2, animated: true)
        completion?(["result": avc_sub2])
    }
    
}
