//
//  Route.swift
//  SwiftyURLRouter
//
//  Created by Dsee.Lab on 2021/2/19.
//

import Foundation

public struct Route {
    
    public let url: URLConvertible
    public let parameter: RouteParameter?
    public let callback: RouteCompletion?
    
    public init(
        _ url: URLConvertible,
        parameter: RouteParameter? = nil,
        completion: RouteCompletion? = nil
    ) {
        self.url = url
        self.parameter = parameter
        self.callback = completion
    }
    
    public init(_ full: FullComponent) {
        self.init(
            full.url,
            parameter: full.routeParameter,
            completion: full.callback?.value as? RouteCompletion
        )
    }
    
    public init(@RouterURLBuilder _ builder: () -> RouteComponent) {
        let components = builder()
        if let full = components as? FullComponent {
            self.init(full)
        } else if let module = components as? Module {
            if let defaultScheme = RouterURLBuilder.defaultScheme {
                self.init(
                    FullComponent(
                        scheme: defaultScheme,
                        modules: [module],
                        queries: [],
                        params: [],
                        callback: nil
                    )
                )
            } else {
                fatalError("You must have 1 scheme, or you can set RouterURLBuilder.defaultScheme to use as the scheme")
            }
        } else {
            // Impossible
            fatalError("Something went wrong")
        }
    }
    
}

public extension Route {
    
    func route() {
        #if DEBUG
        print("SwiftyURLRouter Will Route: \(url)\nwith params: \n\(parameter ?? [:])")
        #endif
        SchemeFactory.shared.routerForUrl(url)?.route(url, parameter: parameter, completion: callback)
    }
    
    func fetch() -> Any? {
        #if DEBUG
        print("SwiftyURLRouter Will Fetch: \(url)\nwith params: \n\(parameter ?? [:])")
        #endif
        return SchemeFactory.shared.routerForUrl(url)?.fetch(url, parameter: parameter, completion: callback)
    }
}
