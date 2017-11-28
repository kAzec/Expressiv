//
//  LayoutPointProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import CoreGraphics

public struct LayoutPointProperty : LayoutCompoundProperty {
    public typealias CompoundConstraint = LayoutConstraintPair
    
    let item: AnyObject
    
    public let xAttribute: LayoutConstraint.Attribute
    public let yAttribute: LayoutConstraint.Attribute
    
    /// The offset value for the x-axis.
    public var dx: CGFloat = 0.0
    /// The offset value for the y-axis.
    public var dy: CGFloat = 0.0
    
    public var x: LayoutXAxisProperty {
        return LayoutXAxisProperty(item: item, attribute: xAttribute, constant: dx)
    }
    
    public var y: LayoutYAxisProperty {
        return LayoutYAxisProperty(item: item, attribute: yAttribute, constant: dy)
    }
    
    @discardableResult
    public static func ==(lhs: LayoutPointProperty, rhs: LayoutPointProperty) -> LayoutConstraintPair {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .equal)
    }
    
    @discardableResult
    public static func >=(lhs: LayoutPointProperty, rhs: LayoutPointProperty) -> LayoutConstraintPair {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
    }
    
    @discardableResult
    public static func <=(lhs: LayoutPointProperty, rhs: LayoutPointProperty) -> LayoutConstraintPair {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
    }
    
    public static func +(lhs: LayoutPointProperty, rhs: CGVector) -> LayoutPointProperty {
        var property = lhs
        property.dx += rhs.dx
        property.dy += rhs.dy
        return property
    }
    
    public static func -(lhs: LayoutPointProperty, rhs: CGVector) -> LayoutPointProperty {
        var property = lhs
        property.dx -= rhs.dx
        property.dy -= rhs.dy
        return property
    }
    
    private static func formConstraints(lhs: LayoutPointProperty, rhs: LayoutPointProperty, relation: LayoutConstraint.Relation)
        -> LayoutConstraintPair
    {
        let x = LayoutConstraint(
            item: lhs.item, attribute: lhs.xAttribute,
            relatedBy: relation,
            toItem: rhs.item, attribute: rhs.xAttribute,
            multiplier: 1.0,
            constant: rhs.dx - lhs.dx)
        let y = LayoutConstraint(
            item: lhs.item, attribute: lhs.yAttribute,
            relatedBy: relation,
            toItem: rhs.item, attribute: rhs.yAttribute,
            multiplier: 1.0,
            constant: rhs.dy - lhs.dy)
        
        if let context = LayoutContext.current {
            context.capture(x)
            context.capture(y)
        }
        
        return LayoutConstraintPair(horizontal: x, vertical: y)
    }
}
