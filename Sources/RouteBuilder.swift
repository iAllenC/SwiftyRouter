//
//  URLComponents.swift
//  SwiftyURLRouter
//
//  Created by Dsee.Lab on 2021/2/18.
//

import Foundation

public enum URLComponentsType {
    case scheme
    case module
    case parameter
    case query
    case callback
}

public protocol URLComponents {
    var type: URLComponentsType { get }
    var key: String? { get }
    var value: Any? { get }
}

public extension URLComponents {
    var key: String? { nil }
}

public struct Scheme: URLComponents {
    
    public var type: URLComponentsType { .scheme }
    public let value: Any?
    
    public init(_ value: String) {
        self.value = value
    }
    
}

public struct Module: URLComponents {
    
    public var type: URLComponentsType { .module }
    public let value: Any?
    
    public init(_ value: String) {
        self.value = value
    }
}

public struct Query: URLComponents {
    public var type: URLComponentsType { .query }
    public let key: String?
    public let value: Any?
    
    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

public struct Parameter: URLComponents {
    
    public var type: URLComponentsType { .parameter }
    public let key: String?
    public let value: Any?
    
    public init(key: String, value: Any?) {
        self.key = key
        self.value = value
    }

}

public struct Callback: URLComponents {
    
    public var type: URLComponentsType { .callback }
    public let value: Any?
    
    public init(_ callback: @escaping RouteCompletion) {
        value = callback
    }

}

public struct URLRoute {
    
    public let scheme: Scheme
    public let modules: [Module]
    public let queries: [Query]
    public let params: [Parameter]
    public let callback: Callback?
    
    var url: String {
        let scheme = self.scheme.value as! String
        var url = scheme + "://" + modules.compactMap{ $0.value as? String }.joined(separator: "/")
        url += queries.reduce("?") {
            guard let key = $1.key, let value = $1.value else { return $0 }
            return $0 + "\(key)=\(value)&"
        }
        url.remove(at: url.index(before: url.endIndex))
        return url
    }
    
    var routeParameter: [String: Any?] {
        var params = [String: Any?]()
        for param in self.params {
            params[param.key!] = param.value
        }
        return params
    }
}

@_functionBuilder
public struct RouterURLBuilder {
    
    public static var defaultScheme: Scheme?
    
    public static func buildBlock(_ components: URLComponents...) -> URLRoute {
        let schemes = components.filter { $0.type == .scheme }
        guard schemes.count == 1 || defaultScheme != nil else { fatalError("You must have 1 scheme, or you can set RouterURLBuilder.defaultScheme to use as the scheme") }
        let scheme = schemes.first ?? defaultScheme
        let modules = components.filter({ $0.type == .module })
        guard modules.count > 0 else { fatalError("You must have at least 1 module") }
        let queries = components.filter { $0.type == .query }
        let params = components.filter { $0.type == .parameter }
        let callbacks = components.filter { $0.type == .callback }
        guard callbacks.count <= 1 else { fatalError("You must have at most 1 call back") }
        return URLRoute(
            scheme: scheme as! Scheme,
            modules: modules as! [Module],
            queries: queries as! [Query],
            params: params as! [Parameter],
            callback: callbacks.first as? Callback
        )
    }
    
}

public func Route(@RouterURLBuilder _ builder: () -> URLRoute) {
    let route = builder()
    Route(
        route.url,
        parameter: route.routeParameter,
        completion: route.callback?.value as? RouteCompletion
    )
}

public func Fetch(@RouterURLBuilder _ builder: () -> URLRoute) -> Any? {
    let route = builder()
    return Fetch(
        route.url,
        parameter: route.routeParameter,
        completion: route.callback?.value as? RouteCompletion
    )
}
