//
//  Distribute.swift
//  Expressiv
//
//  Created by Fengwei Liu on 12/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import CoreGraphics

public enum DistributionMode {
    case horizontally, vertically, leftToRight
    
    fileprivate var combiner: ((View, View, CGFloat) -> LayoutConstraint) {
        switch self {
        case .horizontally:
            return {
                LayoutConstraint(
                    item: $1, attribute: .leading,
                    relatedBy: .equal,
                    toItem: $0, attribute: .trailing,
                    multiplier: 1.0, constant: $2)
            }
        case .vertically:
            return {
                LayoutConstraint(
                    item: $1, attribute: .top,
                    relatedBy: .equal,
                    toItem: $0, attribute: .bottom,
                    multiplier: 1.0, constant: $2)
            }
        case .leftToRight:
            return {
                LayoutConstraint(
                    item: $1, attribute: .left,
                    relatedBy: .equal,
                    toItem: $0, attribute: .right,
                    multiplier: 1.0, constant: $2)
            }
        }
    }
    
    #if os(iOS) || os(tvOS)
    @available(iOS 11.0, tvOS 11.0, *)
    fileprivate var combinerBySystemSpacing: ((View, View, CGFloat) -> LayoutConstraint) {
        switch self {
        case .horizontally:
            return { $1.leadingAnchor.constraintEqualToSystemSpacingAfter($0.trailingAnchor, multiplier: $2) }
        case .vertically:
            return { $1.topAnchor.constraintEqualToSystemSpacingBelow($0.bottomAnchor, multiplier: $2) }
        case .leftToRight:
            return { $1.leftAnchor.constraintEqualToSystemSpacingAfter($0.rightAnchor, multiplier: $2) }
        }
    }
    #endif
}

@discardableResult
public func distribute(_ proxies: [LayoutProxy<View>], _ mode: DistributionMode, spacing: CGFloat = 0.0)
    -> [LayoutConstraint]
{
    return distribute(proxies, mode.combiner, spacing)
}

@discardableResult
public func distribute(_ views: [View], _ mode: DistributionMode, spacing: CGFloat = 0.0) -> [LayoutConstraint] {
    return distribute(views, mode.combiner, spacing)
}

#if os(iOS) || os(tvOS)
@available(iOS 11.0, tvOS 11.0, *)
@discardableResult
public func distributeBySystemSpacing(_ views: [View], _ mode: DistributionMode, multiplier: CGFloat = 1.0)
    -> [LayoutConstraint]
{
    return distribute(views, mode.combinerBySystemSpacing, multiplier)
}

@available(iOS 11.0, tvOS 11.0, *)
@discardableResult
public func distributeBySystemSpacing(
    _ proxies: [LayoutProxy<View>],
    _ mode: DistributionMode,
    multiplier: CGFloat = 1.0
) -> [LayoutConstraint]
{
    return distribute(proxies, mode.combinerBySystemSpacing, multiplier)
}
#endif

private func distribute(
    _ views: [View],
    _ combine: ((View, View, CGFloat) -> LayoutConstraint),
    _ value: CGFloat
) -> [LayoutConstraint]
{
    var iterator = views.makeIterator()
    
    if let first = iterator.next() {
        var previous = first
        var constraints = [LayoutConstraint]()
        
        while let next = iterator.next() {
            constraints.append(combine(previous, next, value))
            previous = next
        }
        
        LayoutContext.current?.capture(constraints)
        return constraints
    } else {
        return []
    }
}

private func distribute(
    _ proxies: [LayoutProxy<View>],
    _ combine: ((View, View, CGFloat) -> LayoutConstraint),
    _ value: CGFloat
) -> [LayoutConstraint]
{
    var iterator = proxies.makeIterator()
    
    if let first = iterator.next() {
        var previous = first.target
        var constraints = [LayoutConstraint]()
        
        while let proxy = iterator.next() {
            let next = proxy.target
            constraints.append(combine(previous, next, value))
            previous = next
        }
    
        LayoutContext.current?.capture(constraints)
        return constraints
    } else {
        return []
    }
}
