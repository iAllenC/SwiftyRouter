//
//  Register.swift
//  SwiftyURLRouter
//
//  Created by Dsee.Lab on 2021/2/18.
//

import Foundation

@_functionBuilder public struct RouterRegister {
        
    static public func buildBlock(_ routerTypes: Router.Type...) -> [Router.Type] {
        routerTypes
    }
    
}

// The convenience functions to register a router type

public func Register(_ routerType: Router.Type, to scheme: String) {
    var factory = SchemeFactory.shared.factoryForScheme(scheme)
    if factory == nil {
        factory = DefaultFactory(schemes: [scheme])
        SchemeFactory.shared.appendFactory(factory: factory!)
    }
    factory!.register(routerType)
}

public func Register(_ routerTypes: [Router.Type], to scheme: String) {
    routerTypes.forEach { Register($0, to: scheme) }
}

public func Register(scheme: String, @RouterRegister routersBuilder: () ->  [Router.Type]) {
    Register(routersBuilder(), to: scheme)
}

