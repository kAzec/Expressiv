//
//  Distribute.swift
//  Expressiv
//
//  Created by Fengwei Liu on 12/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import CoreGraphics

public enum DistributionMode {
    
    case leadingToTrailing
    
    case topToBottom
    
    case leftToRight
    
    static let vertically: DistributionMode = .topToBottom
    
    static let horizontally: DistributionMode = .leadingToTrailing
}

@_inlineable
@discardableResult
public func distribute(
    _ first: LayoutItem,
    _ rest: LayoutItem...,
    mode: DistributionMode,
    spacing: CGFloat = 0.0
) -> [LayoutConstraint] {
    return makeDistribution(first: first, rest: rest, mode: mode, spacing: spacing)
}

@_inlineable
@discardableResult
public func distribute(_ items: [LayoutItem], mode: DistributionMode, spacing: CGFloat = 0.0) -> [LayoutConstraint] {
    if let first = items.first {
        return makeDistribution(first: first, rest: items.dropFirst(), mode: mode, spacing: spacing)
    } else {
        return []
    }
}

@_inlineable
@discardableResult
public func distribute(
    _ first: LayoutProxyProtocol,
    _ rest: LayoutProxyProtocol...,
    mode: DistributionMode,
    spacing: CGFloat = 0.0
) -> [LayoutConstraint] {
    return makeDistribution(first: first, rest: rest, mode: mode, spacing: spacing)
}

@_inlineable
@discardableResult
public func distribute(
    _ proxies: [LayoutProxyProtocol],
    mode: DistributionMode,
    spacing: CGFloat = 0.0
) -> [LayoutConstraint] {
    if let first = proxies.first {
        return makeDistribution(first: first, rest: proxies.dropFirst(), mode: mode, spacing: spacing)
    } else {
        return []
    }
}

@_versioned
func makeDistribution<Items : Collection>(
    first: LayoutItem,
    rest: Items,
    mode: DistributionMode,
    spacing: CGFloat
) -> [LayoutConstraint] where Items.Element == LayoutItem {
    let connector = mode.connector
    var previous = first
    first.prepareForLayoutProxy()
    
    let constraints: [LayoutConstraint] = rest.map { next in
        defer { previous = next }
        
        next.prepareForLayoutProxy()
        return connector(previous, next, spacing)
    }
    
    LayoutContext.current?.addConstraints(constraints)
    return constraints
}

@_versioned
func makeDistribution<Proxies : Collection>(
    first: LayoutProxyProtocol,
    rest: Proxies,
    mode: DistributionMode,
    spacing: CGFloat
) -> [LayoutConstraint] where Proxies.Element == LayoutProxyProtocol {
    let connector = mode.connector
    var previous = first.base
    
    let constraints: [LayoutConstraint] = rest.map { nextProxy in
        let next = nextProxy.base
        defer { previous = next }
        
        return connector(previous, next, spacing)
    }
    
    LayoutContext.current?.addConstraints(constraints)
    return constraints
}

private extension DistributionMode {
    typealias Connector = ((LayoutItem, LayoutItem, CGFloat) -> LayoutConstraint)
    
    private static func connector(
        from fromAttribute: LayoutConstraint.Attribute,
        to toAttribute: LayoutConstraint.Attribute
    ) -> Connector {
        return {
            LayoutConstraint(
                item:       $1,
                attribute:  fromAttribute,
                relatedBy:  .equal,
                toItem:     $0,
                attribute:  toAttribute,
                multiplier: 1.0,
                constant:   $2
            )
        }
    }
    
    var connector: Connector {
        switch self {
        case .leadingToTrailing:
            return DistributionMode.connector(from: .leading, to: .trailing)
        case .topToBottom:
            return DistributionMode.connector(from: .top, to: .bottom)
        case .leftToRight:
            return DistributionMode.connector(from: .left, to: .right)
        }
    }
}
