//
//  LayoutDimensionProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import CoreGraphics

public struct LayoutDimensionProperty : LayoutProperty {
    
    let item: AnyObject
    
    public let attribute: LayoutConstraint.Attribute
    
    public var multiplier: CGFloat
    
    public var constant: CGFloat
    
    @discardableResult
    public static func ==(lhs: LayoutDimensionProperty, rhs: LayoutDimensionProperty) -> LayoutConstraint {
        return formConstraint(lhs: lhs, rhs: rhs, relation: .equal)
    }
    
    @discardableResult
    public static func >=(lhs: LayoutDimensionProperty, rhs: LayoutDimensionProperty) -> LayoutConstraint {
        return formConstraint(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
    }
    
    @discardableResult
    public static func <=(lhs: LayoutDimensionProperty, rhs: LayoutDimensionProperty) -> LayoutConstraint {
        return formConstraint(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
    }
    
    @discardableResult
    public static func ==(lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutConstraint {
        return lhs.formConstraint(constant: rhs, relation: .equal)
    }
    
    @discardableResult
    public static func >=(lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutConstraint {
        return lhs.formConstraint(constant: rhs, relation: .greaterThanOrEqual)
    }
    
    @discardableResult
    public static func <=(lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutConstraint {
        return lhs.formConstraint(constant: rhs, relation: .lessThanOrEqual)
    }
    
    public static func +(lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutDimensionProperty {
        var property = lhs
        property.constant += rhs
        return property
    }
    
    public static func -(lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutDimensionProperty {
        return lhs + (-rhs)
    }
    
    public static func *(lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutDimensionProperty {
        var property = lhs
        property.multiplier *= rhs
        property.constant *= rhs
        return property
    }
    
    public static func /(lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutDimensionProperty {
        return lhs * (1 / rhs)
    }
    
    private static func formConstraint(lhs: LayoutDimensionProperty, rhs: LayoutDimensionProperty, relation: LayoutConstraint.Relation)
        -> LayoutConstraint
    {
        let constraint = LayoutConstraint(
            item: lhs.item, attribute: lhs.attribute,
            relatedBy: relation,
            toItem: rhs.item, attribute: rhs.attribute,
            multiplier: rhs.multiplier / lhs.multiplier,
            constant: (rhs.constant - lhs.constant) / lhs.multiplier)
        
        LayoutContext.current?.capture(constraint)
        return constraint
    }
    
    private func formConstraint(constant: CGFloat, relation: LayoutConstraint.Relation) -> LayoutConstraint {
        let constraint = LayoutConstraint(
            item: item, attribute: attribute,
            relatedBy: relation,
            toItem: nil, attribute: .notAnAttribute,
            multiplier: 0,
            constant: (constant - self.constant) / multiplier)
        
        LayoutContext.current?.capture(constraint)
        return constraint
    }
}
