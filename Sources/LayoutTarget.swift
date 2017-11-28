//
//  LayoutTarget.swift
//  Expressiv
//
//  Created by Fengwei Liu on 27/11/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

public protocol LayoutTarget : class {
    associatedtype LayoutProxyType
    func makeLayoutProxy() -> LayoutProxyType
}

extension View : LayoutTarget {
    public func makeLayoutProxy() -> LayoutProxy<View> {
        translatesAutoresizingMaskIntoConstraints = false
        return LayoutProxy(target: self)
    }
}

extension LayoutGuide : LayoutTarget {
    public func makeLayoutProxy() -> LayoutProxy<LayoutGuide> {
        return LayoutProxy(target: self)
    }
}
