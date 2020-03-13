//
//  URLRouter.swift
//  URLRouter
//
//  Created by 陈元兵 on 2020/3/12.
//  Copyright © 2020 陈元兵. All rights reserved.
//

import UIKit

@objc protocol URLRouter {
    
    var module: String { get }
    
    func route(_ url: URL, parameter: [String: Any]?, completion: (([String: Any]) -> Void)?)
    
    func fetch(_ url: URL, parameter: [String: Any]?, completion: (([String: Any]) -> Void)?) -> UIViewController?

}

class EmptyRouter: URLRouter {
    
    static let shared: EmptyRouter = EmptyRouter()
    
    var module: String = "Empty"
 
    func route(_ url: URL, parameter: [String: Any]?, completion: (([String: Any]) -> Void)?) {
        completion?(["result":false])
    }

    func fetch(_ url: URL, parameter: [String: Any]?, completion: (([String: Any]) -> Void)?) -> UIViewController? {
        completion?(["result":false])
        return nil
    }
}

class RouterFactory {
    
    static let shared: RouterFactory = RouterFactory()
    
    var routers: [String: URLRouter] = [:]
    
    func router(for module: String) -> URLRouter {
        return routers[module] ?? EmptyRouter.shared
    }
    
    func register(_ router: URLRouter) {
        routers[router.module] = router
    }
    
    func register(_ routers: [URLRouter]) {
        routers.forEach { register($0) }
    }
}


func Route(_ url: URL, parameter: [String: Any]? = nil, completion: (([String: Any]) -> Void)? = nil) {
    RouterFactory.shared.router(for: url.host!).route(url, parameter: parameter, completion: completion)
}

func Fetch(_ url: URL, parameter: [String: Any]? = nil, completion: (([String: Any]) -> Void)? = nil) -> UIViewController? {
    RouterFactory.shared.router(for: url.host!).fetch(url, parameter: parameter, completion: completion)
}

