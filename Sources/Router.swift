//
//  Router.swift
//  Router
//
//  Created by iAllenC on 2020/3/12.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit

public typealias RouteParameter = [String: Any?]
public typealias RouteCompletion = (RouteParameter) -> Void

public protocol Router {
    
    //required
    static var module: String { get }
        
    //optional
    func subRouter(for module: String) -> Router?
        
    //required
    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?)
    
    //optional
    func fetch(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) -> Any?
    
    init()

}

extension Router {
    
    public func subRouter(for module: String) -> Router? { nil  }

    //find the appropriate router for url
    public func subRouter(from url: URLConvertible) -> Router? {
        guard let url = url.asURL, let host = url.host, url.path.count > 0 else { return nil }
        //the first of url.pathComponents is a "/", so we just ignore it
        let pathComponents = [String](url.pathComponents[1..<url.pathComponents.count])
        if host == Self.module {
            guard let targetModule = pathComponents.first else { return nil }
            return subRouter(for: targetModule)
        } else {
            if let matchIndex = pathComponents.firstIndex(of: Self.module), matchIndex < pathComponents.count - 1 {
                let targetModule = pathComponents[pathComponents.index(after: matchIndex)]
                return subRouter(for: targetModule)
            } else {
                return nil
            }
        }
    }

    public func fetch(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) -> Any? { nil }
    
}

private struct EmptyRouter: Router {
            
    static var module: String { "Router.Empty" }
 
    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {
        completion?(["result":false])
    }

    func fetch(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) -> Any? {
        completion?(["result":false])
        return nil
    }
}

public class RouterFactory {
    
    public static let shared: RouterFactory = RouterFactory()
    
    private var routers: [String: () -> Router] = [:]
    
    public func router(for module: String) -> Router {
        return routers.keys.contains(module) ? routers[module]!() : EmptyRouter()
    }
    
    func router(for url: URLConvertible) -> Router {
        if let module = url.asURL?.host, routers.keys.contains(module) {
            var router = routers[module]!()
            while let targetRouter = router.subRouter(from: url) {
                router = targetRouter
            }
            return router
        } else {
            return EmptyRouter()
        }
    }
    
    public func register<T: Router>(_ router: @autoclosure @escaping () -> T) {
        routers[T.module] = router
    }
    
}

// The convenience functions to register a router

public func Register<T: Router>(_ router: @autoclosure @escaping () -> T) {
    RouterFactory.shared.register(router())
}

// The convenience functions to route or fetch a url

public func Route(_ url: URLConvertible, parameter: RouteParameter? = nil, completion: RouteCompletion? = nil) {
    RouterFactory.shared.router(for: url).route(url, parameter: parameter, completion: completion)
}

public func Fetch(_ url: URLConvertible, parameter: RouteParameter? = nil, completion: RouteCompletion? = nil) -> Any? {
    RouterFactory.shared.router(for: url).fetch(url, parameter: parameter, completion: completion)
}
