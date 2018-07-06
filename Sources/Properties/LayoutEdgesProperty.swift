//
//  LayoutEdgesProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import CoreGraphics

public struct LayoutEdgesProperty : LayoutCompoundProperty {
    public typealias LayoutConstraints = LayoutEdgesConstraints
    
    @_versioned
    let item: LayoutItem
    
    /// The insets value used to form the constraint.
    public var insets = EdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    
    public let topAttribute: LayoutYAxisAttribute
    
    public let leftAttribute: LayoutXAxisAttribute
    
    public let bottomAttribute: LayoutYAxisAttribute
    
    public let rightAttribute: LayoutXAxisAttribute
    
    @_inlineable
    public init(
        item: LayoutItem,
        top topAttribute: LayoutYAxisAttribute,
        left leftAttribute: LayoutXAxisAttribute,
        bottom bottomAttribute: LayoutYAxisAttribute,
        right rightAttribute: LayoutXAxisAttribute
    ) {
        self.item = item
        self.topAttribute = topAttribute
        self.leftAttribute = leftAttribute
        self.bottomAttribute = bottomAttribute
        self.rightAttribute = rightAttribute
    }
    
    @_inlineable
    public var top: LayoutYAxisProperty {
        return LayoutYAxisProperty(item: item, attribute: topAttribute, constant: insets.top)
    }
    
    @_inlineable
    public var left: LayoutXAxisProperty {
        return LayoutXAxisProperty(item: item, attribute: leftAttribute, constant: insets.left)
    }
    
    @_inlineable
    public var bottom: LayoutYAxisProperty {
        return LayoutYAxisProperty(item: item, attribute: bottomAttribute, constant: -insets.bottom)
    }
    
    @_inlineable
    public var right: LayoutXAxisProperty {
        return LayoutXAxisProperty(item: item, attribute: rightAttribute, constant: -insets.right)
    }
    
    @_inlineable
    @discardableResult
    public static func == (lhs: LayoutEdgesProperty, rhs: LayoutEdgesProperty) -> LayoutEdgesConstraints {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .equal)
    }
    
    @_inlineable
    @discardableResult
    public static func >= (lhs: LayoutEdgesProperty, rhs: LayoutEdgesProperty) -> LayoutEdgesConstraints {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
    }
    
    @_inlineable
    @discardableResult
    public static func <= (lhs: LayoutEdgesProperty, rhs: LayoutEdgesProperty) -> LayoutEdgesConstraints {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
    }
    
    @_inlineable
    public func insetBy(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> LayoutEdgesProperty {
        var property = self
        property.insets = EdgeInsets(
            top:    property.insets.top + top,
            left:   property.insets.left + left,
            bottom: property.insets.bottom + bottom,
            right:  property.insets.right + right
        )
        
        return property
    }
    
    @_inlineable
    public func inset(by insets: EdgeInsets) -> LayoutEdgesProperty {
        return insetBy(top: insets.top, left: insets.left, bottom: insets.bottom, right: insets.right)
    }
    
    @_versioned
    static func formConstraints(
        lhs: LayoutEdgesProperty,
        rhs: LayoutEdgesProperty,
        relation: LayoutConstraint.Relation
    ) -> LayoutEdgesConstraints {
        let top = LayoutConstraint(
            item:       lhs.item,
            attribute:  lhs.topAttribute.nsAttribute,
            relatedBy:  relation,
            toItem:     rhs.item,
            attribute:  rhs.topAttribute.nsAttribute,
            multiplier: 1.0,
            constant:   rhs.insets.top - lhs.insets.top
        )
        
        let left = LayoutConstraint(
            item:       lhs.item,
            attribute:  lhs.leftAttribute.nsAttribute,
            relatedBy:  relation,
            toItem:     rhs.item,
            attribute:  rhs.leftAttribute.nsAttribute,
            multiplier: 1.0,
            constant:   rhs.insets.left - lhs.insets.left
        )
        
        let bottom = LayoutConstraint(
            item:       lhs.item,
            attribute:  lhs.bottomAttribute.nsAttribute,
            relatedBy:  relation,
            toItem:     rhs.item,
            attribute:  rhs.bottomAttribute.nsAttribute,
            multiplier: 1.0,
            constant:   lhs.insets.bottom - rhs.insets.bottom
        )
        
        let right = LayoutConstraint(
            item:       lhs.item,
            attribute:  lhs.rightAttribute.nsAttribute,
            relatedBy:  relation,
            toItem:     rhs.item,
            attribute:  rhs.rightAttribute.nsAttribute,
            multiplier: 1.0,
            constant:   lhs.insets.right - rhs.insets.right
        )
        
        if let context = LayoutContext.current {
            context.addConstraint(top)
            context.addConstraint(left)
            context.addConstraint(bottom)
            context.addConstraint(right)
        }
        
        return LayoutEdgesConstraints(top: top, left: left, bottom: bottom, right: right)
    }
}
