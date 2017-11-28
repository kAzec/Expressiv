//
//  LayoutSizeProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 28/11/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import CoreGraphics

public struct LayoutSizeProperty : LayoutCompoundProperty {
    public typealias CompoundConstraint = LayoutConstraintPair
    
    let item: AnyObject
    
    /// The offset value for the width of the item.
    public var dw: CGFloat
    /// The offset value for the height of the item.
    public var dh: CGFloat
    /// The multiplier value for both the width and the height of the item.
    public var multiplier: CGFloat
    
    public var width: LayoutXAxisProperty {
        return LayoutXAxisProperty(item: item, attribute: .width, constant: dw)
    }
    
    public var height: LayoutYAxisProperty {
        return LayoutYAxisProperty(item: item, attribute: .height, constant: dh)
    }
    
    @discardableResult
    public static func ==(lhs: LayoutSizeProperty, rhs: LayoutSizeProperty) -> LayoutConstraintPair {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .equal)
    }
    
    @discardableResult
    public static func >=(lhs: LayoutSizeProperty, rhs: LayoutSizeProperty) -> LayoutConstraintPair {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
    }
    
    @discardableResult
    public static func <=(lhs: LayoutSizeProperty, rhs: LayoutSizeProperty) -> LayoutConstraintPair {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
    }
    
    public static func +(lhs: LayoutSizeProperty, rhs: CGSize) -> LayoutSizeProperty {
        var property = lhs
        property.dw += rhs.width
        property.dh += rhs.height
        return property
    }
    
    public static func -(lhs: LayoutSizeProperty, rhs: CGSize) -> LayoutSizeProperty {
        var property = lhs
        property.dw -= rhs.width
        property.dh -= rhs.height
        return property
    }
    
    public static func *(lhs: LayoutSizeProperty, rhs: CGFloat) -> LayoutSizeProperty {
        var property = lhs
        property.multiplier *= rhs
        property.dh *= rhs
        property.dw *= rhs
        return property
    }
    
    public static func /(lhs: LayoutSizeProperty, rhs: CGFloat) -> LayoutSizeProperty {
        return lhs * (1 / rhs)
    }
    
    private static func formConstraints(lhs: LayoutSizeProperty, rhs: LayoutSizeProperty, relation: LayoutConstraint.Relation)
        -> LayoutConstraintPair
    {
        let multiplier = rhs.multiplier / lhs.multiplier
        let width = LayoutConstraint(
            item: lhs.item, attribute: .width,
            relatedBy: relation,
            toItem: rhs.item, attribute: .width,
            multiplier: multiplier,
            constant: rhs.dw - lhs.dw)
        let height = LayoutConstraint(
            item: lhs.item, attribute: .height,
            relatedBy: relation,
            toItem: rhs.item, attribute: .height,
            multiplier: multiplier,
            constant: rhs.dh - lhs.dh)
        
        if let context = LayoutContext.current {
            context.capture(width)
            context.capture(height)
        }
        
        return LayoutConstraintPair(horizontal: width, vertical: height)
    }
}
