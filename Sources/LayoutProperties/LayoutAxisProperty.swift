//
//  LayoutAxisProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import CoreGraphics

public struct LayoutAxisProperty<Attribute : LayoutAxisAttribute> : LayoutProperty {
    
    let item: LayoutItem
    
    public let attribute: Attribute
    
    public var constant: CGFloat
    
    @_versioned
    init(item: LayoutItem, attribute: Attribute, constant: CGFloat) {
        self.item = item
        self.attribute = attribute
        self.constant = constant
    }
    
    @_inlineable
    @discardableResult
    public static func == (lhs: LayoutAxisProperty, rhs: LayoutAxisProperty) -> LayoutConstraint {
        return formConstraint(lhs: lhs, rhs: rhs, relation: .equal)
    }
    
    @_inlineable
    @discardableResult
    public static func >= (lhs: LayoutAxisProperty, rhs: LayoutAxisProperty) -> LayoutConstraint {
        return formConstraint(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
    }
    
    @_inlineable
    @discardableResult
    public static func <= (lhs: LayoutAxisProperty, rhs: LayoutAxisProperty) -> LayoutConstraint {
        return formConstraint(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
    }
    
    @_inlineable
    public static func + (lhs: LayoutAxisProperty, rhs: CGFloat) -> LayoutAxisProperty {
        var property = lhs
        property.constant = lhs.constant + rhs
        
        return property
    }
    
    @_inlineable
    public static func - (lhs: LayoutAxisProperty, rhs: CGFloat) -> LayoutAxisProperty {
        return lhs + (-rhs)
    }
    
    @_inlineable
    public static func - (lhs: LayoutXAxisProperty, rhs: LayoutXAxisProperty) -> LayoutDimensionProperty {
        return LayoutDimensionProperty(between: lhs, rhs)
    }
    
    @_inlineable
    public static func - (lhs: LayoutYAxisProperty, rhs: LayoutYAxisProperty) -> LayoutDimensionProperty {
        return LayoutDimensionProperty(between: lhs, rhs)
    }
    
    @_versioned
    static func formConstraint(
        lhs: LayoutAxisProperty,
        rhs: LayoutAxisProperty,
        relation: LayoutConstraint.Relation
    ) -> LayoutConstraint {
        let constraint = LayoutConstraint(
            item:       lhs.item,
            attribute:  lhs.attribute.nsAttribute,
            relatedBy:  relation,
            toItem:     rhs.item,
            attribute:  rhs.attribute.nsAttribute,
            multiplier: 1.0,
            constant:   rhs.constant - lhs.constant
        )
        
        LayoutContext.current?.capture(constraint)
        return constraint
    }
}

public typealias LayoutXAxisProperty = LayoutAxisProperty<LayoutXAxisAttribute>
public typealias LayoutYAxisProperty = LayoutAxisProperty<LayoutYAxisAttribute>
