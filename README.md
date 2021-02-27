# SwiftyRouter
轻量级swift页面路由方案，基于协议实现。

[![CI Status](https://img.shields.io/travis/iAllenC/SwiftyURLRouter.svg?style=flat)](https://travis-ci.org/iAllenC/SwiftyURLRouter)
[![Version](https://img.shields.io/cocoapods/v/SwiftyURLRouter.svg?style=flat)](https://cocoapods.org/pods/SwiftyURLRouter)
[![License](https://img.shields.io/cocoapods/l/SwiftyURLRouter.svg?style=flat)](https://cocoapods.org/pods/SwiftyURLRouter)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyURLRouter.svg?style=flat)](https://cocoapods.org/pods/SwiftyURLRouter)

## Requirements

iOS 9.0，swift 5.1

## Installation

```ruby
pod 'SwiftyURLRouter', '~> 3.0.0'
```

## Use

基于协议实现的轻量级页面路由方案

设计原则：基于url实现多级路由，scheme://module/submodule1/submodule2?query + parameter + completion。如：

router://moduleA/moduleA_sub1/moduleA_sub1_sub1/?param1=1&param2=2

基本调用方法为：

```swift
Route(
  "router://moduleA/moduleA_sub1/moduleA_sub1_sub1/?param1=1&param2=2", 
  parameter: ["image": UIImage(named: "image"), "id": 123456]
) {
  print("\($0)")
}
.route()
```

3.0版本后通过function builder支持DSL式调用：

```swift
Route {
    Scheme("router")
    Module("moduleA")
    Module("moduleA_sub1")
    Module("moduleA_sub1_sub1")
    Query(key: "param1", value: "1")
    Query(key: "param2", value: "2")
    Parameter(key: "image", value: UIImage(named: "image"))
    Parameter(key: "id", value: 123456)
    Callback {
      	print("\($0)")
    }
}
.route()
```

具体步骤：

1.实现Router协议：

```swift
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
```

示例：

```swift
struct ARouter: Router {
    
    static var module: String { "moduleA" }
    
    /// 指定该模块的子模块，如无子模块，可不实现
    static func subRouterType(for module: String) -> Router.Type? {
        switch module {
        case ARouterOne.module:
            return ARouterOne.self
        case ARouterTwo.module:
            return ARouterTwo.self
        default:
            return nil
        }
    }
    
    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {
	/// 执行路由逻辑（如跳转页面），传递参数及回调
    }
    
    func fetch(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) -> Any? {
	/// 执行路由逻辑（如跳转页面），传递参数及回调，返回值
    }
}

//MARK: Second level router

struct ARouterOne: Router {
    
    static var module: String { "moduleA_sub1" }
    
    static func subRouterType(for module: String) -> Router.Type? {
        return module == ARouterOneOne.module ? ARouterOneOne.self : nil
    }

    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {
	/// 执行路由逻辑（如跳转页面），传递参数及回调
    }
    
}

struct ARouterTwo: Router {
    
    static var module: String { "moduleA_sub2" }

    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {
	/// 执行路由逻辑（如跳转页面），传递参数及回调
    }
}

//MARK: Third level router

struct ARouterOneOne: Router {
        
    static var module: String { "moduleA_sub1_sub1" }
    
    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {
        /// 执行路由逻辑（如跳转页面），传递参数及回调
    }
}
```

2.注册该实现class/struct的Type(只需注册一级模块，如modulA，其子模块无需注册，在subRouterType(for module: String)中返回即可):

```swift
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
```

以上为三个注册方法，第一个方法注册单个router，第二个方法通过数组注册多个router，第三个方法通过builder注册多个router：

```swift
SchemeFactory.shared.register(scheme: "router") {
    ARouter.self
    BRouter.self
    CRouter.self
    ToolRouter.self
}
```



## Author

iAllenC, 373381941@qq.com

## License

Maker is available under the MIT license. See the LICENSE file for more info.
