//
//  LayoutCenterProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import Foundation

public struct LayoutCenterProperty : LayoutCompoundProperty {
    
    public typealias Offset = (x: CGFloat, y: CGFloat)
    
    public var offset: Offset
    
    let context: LayoutContext
    
    let centerXAnchor: NSLayoutXAxisAnchor
    let centerYAnchor: NSLayoutYAxisAnchor
    
    @discardableResult
    public static func ==(lhs: LayoutCenterProperty, rhs: LayoutCenterProperty) -> [NSLayoutConstraint] {
        let centerXConstraint = lhs.centerXAnchor.constraint(equalTo: rhs.centerXAnchor,
                                                             constant: rhs.offset.x - lhs.offset.x)
        
        let centerYConstraint = lhs.centerYAnchor.constraint(equalTo: rhs.centerYAnchor,
                                                             constant: rhs.offset.y - lhs.offset.y)
        
        let formedConstraints = [centerXConstraint, centerYConstraint]
        lhs.context.captureConstraints(formedConstraints)
        return formedConstraints
    }
    
    @discardableResult
    public static func >=(lhs: LayoutCenterProperty, rhs: LayoutCenterProperty) -> [NSLayoutConstraint] {
        let centerXConstraint = lhs.centerXAnchor.constraint(greaterThanOrEqualTo: rhs.centerXAnchor,
                                                             constant: rhs.offset.x - lhs.offset.x)
        let centerYConstraint = lhs.centerYAnchor.constraint(greaterThanOrEqualTo: rhs.centerYAnchor,
                                                             constant: rhs.offset.y - lhs.offset.y)
        
        let formedConstraints = [centerXConstraint, centerYConstraint]
        lhs.context.captureConstraints(formedConstraints)
        return formedConstraints
    }
    
    @discardableResult
    public static func <=(lhs: LayoutCenterProperty, rhs: LayoutCenterProperty) -> [NSLayoutConstraint] {
        let centerXConstraint = lhs.centerXAnchor.constraint(lessThanOrEqualTo: rhs.centerXAnchor,
                                                             constant: rhs.offset.x - lhs.offset.x)
        let centerYConstraint = lhs.centerYAnchor.constraint(lessThanOrEqualTo: rhs.centerYAnchor,
                                                             constant: rhs.offset.y - lhs.offset.y)
        
        let formedConstraints = [centerXConstraint, centerYConstraint]
        lhs.context.captureConstraints(formedConstraints)
        return formedConstraints
    }
    
    public static func +(lhs: LayoutCenterProperty, rhs: Offset) -> LayoutCenterProperty {
        var property = lhs
        property.offset = Offset(x: lhs.offset.x + rhs.x, y: lhs.offset.y + rhs.y)
        return property
    }
    
    public static func -(lhs: LayoutCenterProperty, rhs: Offset) -> LayoutCenterProperty {
        var property = lhs
        property.offset = Offset(x: lhs.offset.x - rhs.x, y: lhs.offset.y - rhs.y)
        return property
    }
}
