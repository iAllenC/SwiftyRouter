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
            guard let matchIndex = pathComponents.firstIndex(of: Self.module),
                  matchIndex < pathComponents.count - 1
            else { return nil }
            let targetModule = pathComponents[pathComponents.index(after: matchIndex)]
            return subRouterType(for: targetModule)
        }
    }

    public func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {}

    public func fetch(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) -> Any? { nil }
    
}

public extension Router {
    
    func fetchMixedParameters(from url: URLConvertible, parameters: RouteParameter?) -> RouteParameter {
        var mixedParameters: RouteParameter = [:]
        guard let url = url.asURL else { return mixedParameters }
        if let urlParameter = url.queryParameter {
            mixedParameters = urlParameter
        }
        if let parameters = parameters {
            parameters.forEach { mixedParameters[$0] = $1 }
        }
        return mixedParameters
    }
    
    func fetchParameterValue(for key: String, from url: URLConvertible, parameters: RouteParameter?) -> Any? {
        guard let url = url.asURL else { return nil }
        if let urlParameter = url.queryParameter, let value = urlParameter[key] {
            return value
        } else {
            return parameters?[key] as Any?
        }
    }
    
    func fetchInt(_ key: String, from url: URLConvertible, parameter: RouteParameter?) -> Int? {
        if let parameter = parameter, let int = parameter[key] as? Int {
            return int
        } else if let string = url.queryParameter?[key], let int = Int(string) {
            return int
        } else {
            return nil
        }
    }
    
    func fetchDouble(_ key: String, from url: URLConvertible, parameter: RouteParameter?) -> Double? {
        if let parameter = parameter, let double = parameter[key] as? Double {
            return double
        } else if let string = url.queryParameter?[key], let double = Double(string) {
            return double
        } else {
            return nil
        }
    }
    
    func fetchBool(_ key: String, from url: URLConvertible, parameter: RouteParameter?) -> Bool? {
        if let parameter = parameter, let bool = parameter[key] as? Bool {
            return bool
        } else if let string = url.queryParameter?[key] {
            if let int = Double(string) {
                return int == 1
            } else {
                return key == "true"
            }
        } else {
            return nil
        }

    }


}
