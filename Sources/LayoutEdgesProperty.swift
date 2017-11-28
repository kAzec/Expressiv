//
//  LayoutEdgesProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import CoreGraphics

public struct LayoutEdgesProperty : LayoutCompoundProperty {
    public typealias CompoundConstraint = LayoutConstraintGroup
    
    let item: AnyObject
    
    /// The insets value used to form the constraint.
    public var insets: EdgeInsets
    
    public let topAttribute: LayoutConstraint.Attribute
    public let leftAttribute: LayoutConstraint.Attribute
    public let bottomAttribute: LayoutConstraint.Attribute
    public let rightAttribute: LayoutConstraint.Attribute
    
    @discardableResult
    public static func ==(lhs: LayoutEdgesProperty, rhs: LayoutEdgesProperty) -> LayoutConstraintGroup {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .equal)
    }
    
    @discardableResult
    public static func >=(lhs: LayoutEdgesProperty, rhs: LayoutEdgesProperty) -> LayoutConstraintGroup {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
    }
    
    @discardableResult
    public static func <=(lhs: LayoutEdgesProperty, rhs: LayoutEdgesProperty) -> LayoutConstraintGroup {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
    }
    
    public func insetting(left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat) -> LayoutEdgesProperty {
        var property = self
        property.insets = EdgeInsets(
            top: property.insets.top - top,
            left: property.insets.left - left,
            bottom: property.insets.bottom - bottom,
            right: property.insets.right - right)
        
        return property
    }
    
    private static func formConstraints(lhs: LayoutEdgesProperty, rhs: LayoutEdgesProperty, relation: LayoutConstraint.Relation)
        -> LayoutConstraintGroup
    {
        let top = LayoutConstraint(
            item: lhs.item, attribute: lhs.topAttribute,
            relatedBy: relation,
            toItem: rhs.item, attribute: rhs.topAttribute,
            multiplier: 1.0,
            constant: rhs.insets.top - lhs.insets.top)
        let left = LayoutConstraint(
            item: lhs.item, attribute: lhs.leftAttribute,
            relatedBy: relation,
            toItem: rhs.item, attribute: rhs.leftAttribute,
            multiplier: 1.0,
            constant: rhs.insets.left - lhs.insets.left)
        let bottom = LayoutConstraint(
            item: lhs.item, attribute: lhs.bottomAttribute,
            relatedBy: relation,
            toItem: rhs.item, attribute: rhs.bottomAttribute,
            multiplier: 1.0,
            constant: rhs.insets.bottom - lhs.insets.bottom)
        let right = LayoutConstraint(
            item: lhs.item, attribute: lhs.rightAttribute,
            relatedBy: relation,
            toItem: rhs.item, attribute: rhs.rightAttribute,
            multiplier: 1.0,
            constant: rhs.insets.right - lhs.insets.right)
        
        if let context = LayoutContext.current {
            context.capture(top)
            context.capture(left)
            context.capture(bottom)
            context.capture(right)
        }
        
        return LayoutConstraintGroup(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
