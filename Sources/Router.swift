//
//  Router.swift
//  Router
//
//  Created by iAllenC on 2020/3/12.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit

public typealias RouteParameter = [String: Any?]
public typealias RouteCompletion = (Any?) -> Void

public protocol Router {
    
    //required
    init()

    //required
    static var module: String { get }
            
    //optional
    static func subRouterType(for module: String) -> Router.Type?

    //optional
    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?)
    
    //optional
    func fetch(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) -> Any?
    
}

extension Router {
        
    public static func subRouterType(for module: String) -> Router.Type? { nil }

    //find the appropriate router for url
    public static func subRouterType(from url: URLConvertible) -> Router.Type? {
        guard let url = url.asURL, let host = url.host, url.pathComponents.count > 0 else { return nil }
        //the first of url.pathComponents is a "/", so we just ignore it
        let pathComponents = [String](url.pathComponents[1..<url.pathComponents.count])
        if host == Self.module {
            guard let targetModule = pathComponents.first else { return nil }
            return subRouterType(for: targetModule)
        } else {
            if let matchIndex = pathComponents.firstIndex(of: Self.module), matchIndex < pathComponents.count - 1 {
                let targetModule = pathComponents[pathComponents.index(after: matchIndex)]
                return subRouterType(for: targetModule)
            } else {
                return nil
            }
        }
    }

    public func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {}

    public func fetch(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) -> Any? { nil }
    
}

