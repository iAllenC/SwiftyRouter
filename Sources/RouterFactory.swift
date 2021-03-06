//
//  RouterFactory.swift
//  SwiftyURLRouter
//
//  Created by Dsee.Lab on 2020/9/12.
//

import Foundation

// The factory of Router
public protocol RouterFactory {
    
    var schemes: [String] { get }
    
    func router(for url: URLConvertible) -> Router
        
    func register(_ routerType: Router.Type)
    
}

// Default factory type based in Module
class DefaultFactory: RouterFactory {
    
    private struct EmptyRouter: Router {
                
        static var module: String { "Router.Empty" }
     
        func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {
            completion?(false)
        }

        func fetch(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) -> Any? {
            completion?(false)
            return nil
        }
    }
    
    var schemes: [String]

    var routerTypes: [String: Router.Type] = [:]
    
    init(schemes: [String]) {
        self.schemes = schemes
    }
        
    func router(for url: URLConvertible) -> Router {
        if let module = url.asURL?.host, var routerType = routerTypes[module] {
            while let subType = routerType.subRouterType(from: url) {
                routerType = subType
            }
            return routerType.init()
        } else {
            return EmptyRouter()
        }
    }
        
    func register(_ routerType: Router.Type) {
        guard !routerTypes.keys.contains(routerType.module) else {
            #if DEBUG
            fatalError("Already existing routerType for modluel:\(routerType.module)")
            #else
            return
            #endif
        }
        routerTypes[routerType.module] = routerType
    }
    
}

/// The factory of RouterFactory
public class SchemeFactory {
    
    public static let shared = SchemeFactory()
    
    private var factories: [RouterFactory] = []
    
    public func factoryExistsForUrl(_ url: URLConvertible) -> Bool {
        guard let scheme = url.asURL?.scheme else { return false }
        return factoryExistsForScheme(scheme)
    }
    
    public func factoryExistsForScheme(_ scheme: String) -> Bool {
        factories.contains { $0.schemes.contains(scheme) }
    }
    
    public func appendFactory(factory: RouterFactory) {
        factories.append(factory)
    }
    
    public func factoryForScheme(_ scheme: String) -> RouterFactory? {
        factories.first { $0.schemes.contains(scheme) }
    }
    
    public func routerForUrl(_ url: URLConvertible) -> Router? {
        guard let scheme = url.asURL?.scheme else { return nil }
        return factoryForScheme(scheme)?.router(for: url)
    }
}
