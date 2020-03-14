//
//  URLRouter.swift
//  URLRouter
//
//  Created by iAllenC on 2020/3/12.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit

public typealias RouteCompletion = ([String: Any]) -> Void
public typealias RouteHandler = (URLConvertible, [String: Any]?, RouteCompletion?) -> Void
public typealias RouteFetcher = (URLConvertible, [String: Any]?, RouteCompletion?) -> Any?

public protocol URLRouter {
    
    var module: String { get }
        
    func subRouter(for module: String) -> URLRouter?
        
    func route(_ url: URLConvertible, parameter: [String: Any]?, completion: RouteCompletion?)
    
    func fetch(_ url: URLConvertible, parameter: [String: Any]?, completion: RouteCompletion?) -> Any?

}

extension URLRouter {
        
    public func subRouter(for module: String) -> URLRouter? { nil }

    public func subRouter(_ url: URLConvertible) -> URLRouter? {
        let url = url.asURL
        guard let host = url.host, url.path.count > 0 else { return nil }
        //the first of url.pathComponents is a "/", so we just ignore it
        let pathComponents = url.pathComponents[1..<url.pathComponents.count]
        if host == module {
            guard let targetModule = pathComponents.first else { return nil }
            return subRouter(targetModule)
        } else {
            let matchPath = pathComponents.filter { $0 == module }.first
            guard matchPath != nil else { return nil }
            return subRouter(matchPath!)
        }
    }

    public func fetch(_ url: URLConvertible, parameter: [String: Any]?, completion: RouteCompletion?) -> Any? { nil }

    //Try to find a sub router to handle the url, otherwise route the url using the parameter "router"
    public func routeAfterSub(_ url: URLConvertible, parameter: [String: Any]?, completion: RouteCompletion?, router: RouteHandler) {
        if let subRouter = subRouter(url) {
            subRouter.route(url, parameter: parameter, completion: completion)
        } else {
            router(url, parameter, completion)
        }
    }
    
    //Try to find a sub router to fetch the url, otherwise fetch the url using the parameter "fetcher"
    public func fetchAfterSub(_ url: URLConvertible, parameter: [String: Any]?, completion: RouteCompletion?, fetcher: RouteFetcher) -> Any? {
        if let subRouter = subRouter(url) {
            return subRouter.fetch(url, parameter: parameter, completion: completion)
        } else {
            return fetcher(url, parameter, completion)
        }
    }

}

private class EmptyRouter: URLRouter {
            
    var module: String = "URLRouter.Empty"
 
    func route(_ url: URLConvertible, parameter: [String: Any]?, completion: RouteCompletion?) {
        completion?(["result":false])
    }

    func fetch(_ url: URLConvertible, parameter: [String: Any]?, completion: RouteCompletion?) -> Any? {
        completion?(["result":false])
        return nil
    }
}

public class RouterFactory {
    
    public static let shared: RouterFactory = RouterFactory()
    
    private var routers: [String: URLRouter] = [:]
    
    public func router(for module: String) -> URLRouter {
        return routers[module] ?? EmptyRouter()
    }
    
    public func register(_ router: URLRouter) {
        routers[router.module] = router
    }
    
    public func register(_ routers: [URLRouter]) {
        routers.forEach(register)
    }
}

// The convenience functions to route or fetch a url

public func Route(_ url: URLConvertible, parameter: [String: Any]? = nil, completion: RouteCompletion? = nil) {
    RouterFactory.shared.router(for: url.asURL.host!).route(url, parameter: parameter, completion: completion)
}

public func Fetch(_ url: URLConvertible, parameter: [String: Any]? = nil, completion: RouteCompletion? = nil) -> Any? {
    RouterFactory.shared.router(for: url.asURL.host!).fetch(url, parameter: parameter, completion: completion)
}

