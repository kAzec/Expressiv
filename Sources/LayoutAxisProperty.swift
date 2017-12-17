//
//  LayoutAxisProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import CoreGraphics

public protocol LayoutAxis { }
public enum LayoutXAxis : LayoutAxis { }
public enum LayoutYAxis : LayoutAxis { }

public struct LayoutAxisProperty<Axis : LayoutAxis> : LayoutProperty {
    
    let item: AnyObject
    
    public let attribute: LayoutConstraint.Attribute
    
    public var constant: CGFloat
    
    @discardableResult
    public static func ==(lhs: LayoutAxisProperty, rhs: LayoutAxisProperty) -> LayoutConstraint {
        return formConstraint(lhs: lhs, rhs: rhs, relation: .equal)
    }
    
    @discardableResult
    public static func >=(lhs: LayoutAxisProperty, rhs: LayoutAxisProperty) -> LayoutConstraint {
        return formConstraint(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
    }
    
    @discardableResult(()
    public static func <=(lhs: LayoutAxisProperty, rhs: LayoutAxisProperty) -> LayoutConstraint {
        return formConstraint(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
    }
    
    public static func +(lhs: LayoutAxisProperty, rhs: CGFloat) -> LayoutAxisProperty {
        var property = lhs
        property.constant = lhs.constant + rhs
        return property
    }
    
    public static func -(lhs: LayoutAxisProperty, rhs: CGFloat) -> LayoutAxisProperty {
        return lhs + (-rhs)
    }
    
    private static func formConstraint(lhs: LayoutAxisProperty, rhs: LayoutAxisProperty, relation: LayoutConstraint.Relation)
        -> LayoutConstraint
    {
        let constraint = LayoutConstraint(
            item: lhs.item, attribute: lhs.attribute,
            relatedBy: relation,
            toItem: rhs.item, attribute: rhs.attribute,
            multiplier: 1.0,
            constant: rhs.constant - lhs.constant)
        
        LayoutContext.current?.capture(constraint)
        return constraint
    }
}

public typealias LayoutXAxisProperty = LayoutAxisProperty<LayoutXAxis>
public typealias LayoutYAxisProperty = LayoutAxisProperty<LayoutYAxis>
