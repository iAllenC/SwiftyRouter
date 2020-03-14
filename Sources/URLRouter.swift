//
//  URLRouter.swift
//  URLRouter
//
//  Created by iAllenC on 2020/3/12.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit

public protocol URLRouter: class {
    
    var module: String { get }
    
    var subRouters: [String: URLRouter]? { get }
        
    func route(_ url: URLConvertible, parameter: [String: Any]?, completion: (([String: Any]) -> Void)?)
    
    func fetch(_ url: URLConvertible, parameter: [String: Any]?, completion: (([String: Any]) -> Void)?) -> UIViewController?

}

extension URLRouter {
    
    var subRouters: [String: URLRouter]? { nil }
    
    func fetch(_ url: URLConvertible, parameter: [String: Any]?, completion: (([String: Any]) -> Void)?) -> UIViewController? {
        return nil
    }

    func subRouter(_ url: URLConvertible) -> URLRouter? {
        let url = url.asURL
        guard let host = url.host, url.path.count > 0 else { return nil }
        let pathComponents = url.pathComponents[1..<url.pathComponents.count]
        if host == module {
            if let targetModule = pathComponents.first {
                return subRouters?[targetModule]
            } else {
                return nil
            }
        } else {
            let matchPath = pathComponents.filter { $0 == module }.first
            if let matchPath = matchPath {
                return subRouters?[matchPath]
            } else {
                return nil
            }
        }
    }

}

private class EmptyRouter: URLRouter {
    
    static let shared: EmptyRouter = EmptyRouter()

    var subRouters: [String : URLRouter]?
        
    var module: String = "Empty"
 
    func route(_ url: URLConvertible, parameter: [String: Any]?, completion: (([String: Any]) -> Void)?) {
        completion?(["result":false])
    }

    func fetch(_ url: URLConvertible, parameter: [String: Any]?, completion: (([String: Any]) -> Void)?) -> UIViewController? {
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


public func Route(_ url: URLConvertible, parameter: [String: Any]? = nil, completion: (([String: Any]) -> Void)? = nil) {
    RouterFactory.shared.router(for: url.asURL.host!).route(url, parameter: parameter, completion: completion)
}

public func Fetch(_ url: URLConvertible, parameter: [String: Any]? = nil, completion: (([String: Any]) -> Void)? = nil) -> UIViewController? {
    RouterFactory.shared.router(for: url.asURL.host!).fetch(url, parameter: parameter, completion: completion)
}

