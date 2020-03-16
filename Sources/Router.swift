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
public typealias RouteHandler = (URLConvertible, RouteParameter?, RouteCompletion?) -> Void
public typealias RouteFetcher = (URLConvertible, RouteParameter?, RouteCompletion?) -> Any?

public protocol Router {
    
    static var module: String { get }
        
    func subRouter(for module: String) -> Router?
        
    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?)
    
    func fetch(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) -> Any?

}

extension Router {
        
    public func subRouter(for module: String) -> Router? { nil }

    public func subRouter(from url: URLConvertible) -> Router? {
        let url = url.asURL
        guard let host = url.host, url.path.count > 0 else { return nil }
        //the first of url.pathComponents is a "/", so we just ignore it
        let pathComponents = url.pathComponents[1..<url.pathComponents.count]
        if host == Self.module {
            guard let targetModule = pathComponents.first else { return nil }
            return subRouter(for: targetModule)
        } else {
            let matchPath = pathComponents.filter { $0 == Self.module }.first
            guard matchPath != nil else { return nil }
            return subRouter(for: matchPath!)
        }
    }

    public func fetch(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) -> Any? { nil }

    //Try to find a sub router to handle the url, otherwise route the url using the parameter "router"
    public func routeAfterSub(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?, router: RouteHandler) {
        if let subRouter = subRouter(from: url) {
            subRouter.route(url, parameter: parameter, completion: completion)
        } else {
            router(url, parameter, completion)
        }
    }
    
    //Try to find a sub router to fetch the url, otherwise fetch the url using the parameter "fetcher"
    public func fetchAfterSub(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?, fetcher: RouteFetcher) -> Any? {
        if let subRouter = subRouter(from: url) {
            return subRouter.fetch(url, parameter: parameter, completion: completion)
        } else {
            return fetcher(url, parameter, completion)
        }
    }

}

private class EmptyRouter: Router {
            
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
    
    public func register<T: Router>(_ router:@autoclosure @escaping () -> T) {
        routers[T.module] = router
    }
    
}

// The convenience functions to route or fetch a url

public func Route(_ url: URLConvertible, parameter: RouteParameter? = nil, completion: RouteCompletion? = nil) {
    RouterFactory.shared.router(for: url.asURL.host!).route(url, parameter: parameter, completion: completion)
}

public func Fetch(_ url: URLConvertible, parameter: RouteParameter? = nil, completion: RouteCompletion? = nil) -> Any? {
    RouterFactory.shared.router(for: url.asURL.host!).fetch(url, parameter: parameter, completion: completion)
}


