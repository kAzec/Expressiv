//
//  Align.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

@_inlineable
@discardableResult
public func align(
    _ attribute: LayoutConstraint.Attribute,
    for first: LayoutItem,
    _ rest: LayoutItem...
) -> [LayoutConstraint] {
    return makeAlignment(attribute: attribute, first: first, rest: rest)
}

@_inlineable
@discardableResult
public func align(
    _ attribute: LayoutConstraint.Attribute,
    for items: [LayoutItem]
) -> [LayoutConstraint] {
    if let first = items.first {
        return makeAlignment(attribute: attribute, first: first, rest: items.dropFirst())
    } else {
        return []
    }
}

@_inlineable
@discardableResult
public func align(
    _ attribute: LayoutConstraint.Attribute,
    for first: AnyLayoutProxy,
    _ rest: AnyLayoutProxy...
) -> [LayoutConstraint] {
    return makeAlignment(attribute: attribute, first: first, rest: rest)
}

@_inlineable
@discardableResult
public func align(
    _ attribute: LayoutConstraint.Attribute,
    for proxies: [AnyLayoutProxy]
) -> [LayoutConstraint] {
    if let first = proxies.first {
        return makeAlignment(attribute: attribute, first: first, rest: proxies.dropFirst())
    } else {
        return []
    }
}

@_versioned
func makeAlignment<LayoutItems : Collection>(
    attribute: LayoutConstraint.Attribute,
    first: LayoutItem,
    rest: LayoutItems
) -> [LayoutConstraint] where LayoutItems.Element == LayoutItem {
    first.prepareForLayoutProxy()
    
    let constraints: [LayoutConstraint] = rest.map { item in
        item.prepareForLayoutProxy()
        
        return LayoutConstraint(
            item:       first,
            attribute:  attribute,
            relatedBy:  .equal,
            toItem:     item,
            attribute:  attribute,
            multiplier: 1.0,
            constant:   0.0
        )
    }
    
    LayoutContext.current?.capture(constraints)
    return constraints
}

@_versioned
func makeAlignment<LayoutProxies : Collection>(
    attribute: LayoutConstraint.Attribute,
    first: AnyLayoutProxy,
    rest: LayoutProxies
) -> [LayoutConstraint] where LayoutProxies.Element == AnyLayoutProxy {
    let first = first.base
    
    let constraints: [LayoutConstraint] = rest.map { proxy in
        return LayoutConstraint(
            item:       first,
            attribute:  attribute,
            relatedBy:  .equal,
            toItem:     proxy.base,
            attribute:  attribute,
            multiplier: 1.0,
            constant:   0.0
        )
    }
    
    LayoutContext.current?.capture(constraints)
    return constraints
}
