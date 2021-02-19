//
//  Route.swift
//  SwiftyURLRouter
//
//  Created by Dsee.Lab on 2021/2/19.
//

import Foundation

// The convenience functions to route or fetch a url

public func Route(_ url: URLConvertible, parameter: RouteParameter? = nil, completion: RouteCompletion? = nil) {
    #if DEBUG
    print("SwiftyURLRouter Will Route: \(url)\nwith params: \n\(parameter ?? [:])")
    #endif
    guard let scheme = url.asURL?.scheme else { return }
    SchemeFactory.shared.factoryForScheme(scheme)?.router(for: url).route(url, parameter: parameter, completion: completion)
}

public func Fetch(_ url: URLConvertible, parameter: RouteParameter? = nil, completion: RouteCompletion? = nil) -> Any? {
    #if DEBUG
    print("SwiftyURLRouter Will Fetch: \(url)\nwith params: \n\(parameter ?? [:])")
    #endif
    guard let scheme = url.asURL?.scheme else { return nil }
    return SchemeFactory.shared.factoryForScheme(scheme)?.router(for: url).fetch(url, parameter: parameter, completion: completion)
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
