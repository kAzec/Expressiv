//
//  LayoutEdgeProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import Foundation

public struct LayoutEdgeProperty<T : AnyObject, Anchor : NSLayoutAnchor<T>> : LayoutProperty {
    
    public var constant: CGFloat
    
    let context: LayoutContext
    
    let anchor: Anchor
    
    
    @discardableResult
    public static func ==(lhs: LayoutEdgeProperty<T, Anchor>, rhs: LayoutEdgeProperty<T, Anchor>)
        -> NSLayoutConstraint {
            
        let formedConstraint = lhs.anchor.constraint(equalTo: rhs.anchor, constant: rhs.constant - lhs.constant)
        lhs.context.captureConstraint(formedConstraint)
        return formedConstraint
    }
    
    @discardableResult
    public static func >=(lhs: LayoutEdgeProperty<T, Anchor>, rhs: LayoutEdgeProperty<T, Anchor>)
        -> NSLayoutConstraint {
            
        let formedConstraint = lhs.anchor.constraint(greaterThanOrEqualTo: rhs.anchor, constant: rhs.constant - lhs.constant)
        lhs.context.captureConstraint(formedConstraint)
        return formedConstraint
    }
    
    @discardableResult
    public static func <=(lhs: LayoutEdgeProperty<T, Anchor>, rhs: LayoutEdgeProperty<T, Anchor>)
        -> NSLayoutConstraint {
            
        let formedConstraint = lhs.anchor.constraint(lessThanOrEqualTo: rhs.anchor, constant: rhs.constant - lhs.constant)
        lhs.context.captureConstraint(formedConstraint)
        return formedConstraint
    }
    
    public static func +(lhs: LayoutEdgeProperty<T, Anchor>, rhs: CGFloat) -> LayoutEdgeProperty<T, Anchor> {
        var property = lhs
        property.constant = lhs.constant + rhs
        return property
    }
    
    public static func -(lhs: LayoutEdgeProperty<T, Anchor>, rhs: CGFloat) -> LayoutEdgeProperty<T, Anchor> {
        return lhs + (-rhs)
    }
}

public typealias LayoutXAxisProperty = LayoutEdgeProperty<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor>
public typealias LayoutYAxisProperty = LayoutEdgeProperty<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor>
