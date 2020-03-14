//
//  URLConvertible.swift
//  URLRouter
//
//  Created by Dsee.Lab on 2020/3/14.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import Foundation
public protocol URLConvertible {
    var asURL: URL { get }
    var queryParameter: [String: String]? { get }
}

public extension URLConvertible {
    var queryParameter: [String: String]? {
        asURL.queryParameter
    }
}

extension URL: URLConvertible {
    public var asURL: URL {
        self
    }
}

extension String: URLConvertible {
    public var asURL: URL {
        URL(string: self)!
    }
}
