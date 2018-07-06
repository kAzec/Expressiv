//
//  LayoutPointProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import CoreGraphics

public struct LayoutPointProperty : LayoutCompoundProperty {
    public typealias LayoutConstraints = LayoutPointConstraints
    
    @_versioned
    let item: LayoutItem
    
    public let xAttribute: LayoutXAxisAttribute
    
    public let yAttribute: LayoutYAxisAttribute
    
    /// The offset value for the x-axis.
    public var dx: CGFloat = 0.0
    /// The offset value for the y-axis.
    public var dy: CGFloat = 0.0
    
    @_inlineable
    public init(item: LayoutItem, x xAttribute: LayoutXAxisAttribute, y yAttribute: LayoutYAxisAttribute) {
        self.item = item
        self.xAttribute = xAttribute
        self.yAttribute = yAttribute
    }
    
    @_inlineable
    public var x: LayoutXAxisProperty {
        return LayoutXAxisProperty(item: item, attribute: xAttribute, constant: dx)
    }
    
    @_inlineable
    public var y: LayoutYAxisProperty {
        return LayoutYAxisProperty(item: item, attribute: yAttribute, constant: dy)
    }
    
    @_inlineable
    @discardableResult
    public static func == (lhs: LayoutPointProperty, rhs: LayoutPointProperty) -> LayoutPointConstraints {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .equal)
    }
    
    @_inlineable
    @discardableResult
    public static func >= (lhs: LayoutPointProperty, rhs: LayoutPointProperty) -> LayoutPointConstraints {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
    }
    
    @_inlineable
    @discardableResult
    public static func <= (lhs: LayoutPointProperty, rhs: LayoutPointProperty) -> LayoutPointConstraints {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
    }
    
    @_inlineable
    public static func + (lhs: LayoutPointProperty, rhs: CGVector) -> LayoutPointProperty {
        var property = lhs
        property.dx += rhs.dx
        property.dy += rhs.dy
        
        return property
    }
    
    @_inlineable
    public static func - (lhs: LayoutPointProperty, rhs: CGVector) -> LayoutPointProperty {
        var property = lhs
        property.dx -= rhs.dx
        property.dy -= rhs.dy
        
        return property
    }
    
    @_versioned
    static func formConstraints(
        lhs: LayoutPointProperty,
        rhs: LayoutPointProperty,
        relation: LayoutConstraint.Relation
    ) -> LayoutPointConstraints {
        let x = LayoutConstraint(
            item:       lhs.item,
            attribute:  lhs.xAttribute.nsAttribute,
            relatedBy:  relation,
            toItem:     rhs.item,
            attribute:  rhs.xAttribute.nsAttribute,
            multiplier: 1.0,
            constant:   rhs.dx - lhs.dx
        )
        
        let y = LayoutConstraint(
            item:       lhs.item,
            attribute:  lhs.yAttribute.nsAttribute,
            relatedBy:  relation,
            toItem:     rhs.item,
            attribute:  rhs.yAttribute.nsAttribute,
            multiplier: 1.0,
            constant:   rhs.dy - lhs.dy
        )
        
        if let context = LayoutContext.current {
            context.addConstraint(x)
            context.addConstraint(y)
        }
        
        return LayoutPointConstraints(x: x, y: y)
    }
}
