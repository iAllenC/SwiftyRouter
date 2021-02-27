//
//  Register.swift
//  SwiftyURLRouter
//
//  Created by Dsee.Lab on 2021/2/18.
//

import Foundation

public extension SchemeFactory {
    
    @_functionBuilder struct RegisterBuilder {
        static public func buildBlock(_ routerTypes: Router.Type...) -> [Router.Type] {
            routerTypes
        }
    }

    func register(_ routerTypes: [Router.Type], to scheme: String) {
        routerTypes.forEach { register($0, to: scheme) }
    }
    
    func register(_ routerType: Router.Type, to scheme: String) {
        var factory = factoryForScheme(scheme)
        if factory == nil {
            factory = DefaultFactory(schemes: [scheme])
            SchemeFactory.shared.appendFactory(factory: factory!)
        }
        factory!.register(routerType)
    }
    
    func register(scheme: String, @RegisterBuilder builder: () ->  [Router.Type]) {
        builder().forEach { register($0, to: scheme) }
    }

}

