# SwiftyRouter
轻量级swift页面路由方案，基于协议实现。

[![CI Status](https://img.shields.io/travis/iAllenC/SwiftyRouter.svg?style=flat)](https://travis-ci.org/iAllenC/SwiftyRouter)
[![Version](https://img.shields.io/cocoapods/v/SwiftyRouter.svg?style=flat)](https://cocoapods.org/pods/SwiftyRouter)
[![License](https://img.shields.io/cocoapods/l/SwiftyRouter.svg?style=flat)](https://cocoapods.org/pods/SwiftyRouter)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyRouter.svg?style=flat)](https://cocoapods.org/pods/SwiftyRouter)

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
        let alert = UIAlertController(title: "Alert", message: "This is a third level layer", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        UIViewController.topViewController?.present(alert, animated: true) {
            completion?(["result": true])
        }
    }
}
```

2.注册该实现class/struct的Type:

```swift
public func Register(_ routerType: Router.Type, to scheme: String)

public func Register(_ routerTypes: [Router.Type], to scheme: String)

public func Register(scheme: String, @RouterRegister routersBuilder: () ->  [Router.Type])

```

以上为三个注册方法，第一个方法注册单个router，第二个方法通过数组注册多个router，第三个方法通过builder注册多个router：

```swift
Register(scheme: "router") {
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
