//
//  LayoutDimensionProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import Foundation

public struct LayoutDimensionProperty : LayoutProperty {
    
    public typealias Coefficient = CGFloat
    
    public var multiplier: CGFloat
    
    public var constant: CGFloat
    
    let context: LayoutContext
    
    let dimension: NSLayoutDimension
    
    
    @discardableResult
    public static func ==(lhs: LayoutDimensionProperty, rhs: LayoutDimensionProperty) -> NSLayoutConstraint {
        let multiplier = rhs.multiplier / lhs.multiplier
        let constant = (rhs.constant - lhs.constant) / lhs.multiplier
        let formedConstraint = lhs.dimension.constraint(equalTo: rhs.dimension, multiplier: multiplier, constant: constant)
        
        lhs.context.captureConstraint(formedConstraint)
        return formedConstraint
    }
    
    @discardableResult
    public static func >=(lhs: LayoutDimensionProperty, rhs: LayoutDimensionProperty) -> NSLayoutConstraint {
        let multiplier = rhs.multiplier / lhs.multiplier
        let constant = (rhs.constant - lhs.constant) / lhs.multiplier
        let formedConstraint = lhs.dimension.constraint(greaterThanOrEqualTo: rhs.dimension, multiplier: multiplier,
                                                  constant: constant)
        
        lhs.context.captureConstraint(formedConstraint)
        return formedConstraint
    }
    
    @discardableResult
    public static func <=(lhs: LayoutDimensionProperty, rhs: LayoutDimensionProperty) -> NSLayoutConstraint {
        let multiplier = rhs.multiplier / lhs.multiplier
        let constant = (rhs.constant - lhs.constant) / lhs.multiplier
        let formedConstraint = lhs.dimension.constraint(lessThanOrEqualTo: rhs.dimension, multiplier: multiplier,
                                                  constant: constant)
        
        lhs.context.captureConstraint(formedConstraint)
        return formedConstraint
    }
    
    public static func +(lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutDimensionProperty {
        var property = lhs
        property.constant = lhs.constant + rhs
        return property
    }
    
    public static func -(lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutDimensionProperty {
        return lhs + (-rhs)
    }
    
    public static func *(lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutDimensionProperty {
        var property = lhs
        property.multiplier = lhs.constant * rhs
        property.constant = lhs.constant * rhs
        return property
    }
    
    public static func /(lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutDimensionProperty {
        return lhs * (1 / rhs)
    }
}
