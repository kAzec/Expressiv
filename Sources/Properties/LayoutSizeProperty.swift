//
//  LayoutSizeProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 28/11/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import CoreGraphics

public struct LayoutSizeProperty : LayoutCompoundProperty {
    public typealias LayoutConstraints = LayoutSizeConstraints
    
    @_versioned
    let item: LayoutItem
    
    /// The offset value for the width of the item.
    public var dw: CGFloat = 0.0
    /// The offset value for the height of the item.
    public var dh: CGFloat = 0.0
    /// The multiplier value for both the width and the height of the item.
    public var multiplier: CGFloat = 1.0
    
    @_inlineable
    public init(item: LayoutItem) {
        self.item = item
    }
    
    @_inlineable
    public var width: LayoutDimensionProperty {
        return LayoutDimensionProperty(item: item, attribute: .width, constant: dw)
    }
    
    @_inlineable
    public var height: LayoutDimensionProperty {
        return LayoutDimensionProperty(item: item, attribute: .height, constant: dh)
    }
    
    @_inlineable
    @discardableResult
    public static func == (lhs: LayoutSizeProperty, rhs: LayoutSizeProperty) -> LayoutSizeConstraints {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .equal)
    }
    
    @_inlineable
    @discardableResult
    public static func >= (lhs: LayoutSizeProperty, rhs: LayoutSizeProperty) -> LayoutSizeConstraints {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
    }
    
    @_inlineable
    @discardableResult
    public static func <= (lhs: LayoutSizeProperty, rhs: LayoutSizeProperty) -> LayoutSizeConstraints {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
    }
    
    @_inlineable
    @discardableResult
    public static func == (lhs: LayoutSizeProperty, rhs: CGSize) -> LayoutSizeConstraints {
        return lhs.formConstraints(size: rhs, relation: .equal)
    }
    
    @_inlineable
    @discardableResult
    public static func >= (lhs: LayoutSizeProperty, rhs: CGSize) -> LayoutSizeConstraints {
        return lhs.formConstraints(size: rhs, relation: .greaterThanOrEqual)
    }
    
    @_inlineable
    @discardableResult
    public static func <= (lhs: LayoutSizeProperty, rhs: CGSize) -> LayoutSizeConstraints {
        return lhs.formConstraints(size: rhs, relation: .lessThanOrEqual)
    }
    
    @_inlineable
    public static func + (lhs: LayoutSizeProperty, rhs: CGSize) -> LayoutSizeProperty {
        var property = lhs
        property.dw += rhs.width
        property.dh += rhs.height
        return property
    }
    
    @_inlineable
    public static func - (lhs: LayoutSizeProperty, rhs: CGSize) -> LayoutSizeProperty {
        var property = lhs
        property.dw -= rhs.width
        property.dh -= rhs.height
        return property
    }
    
    @_inlineable
    public static func * (lhs: LayoutSizeProperty, rhs: CGFloat) -> LayoutSizeProperty {
        var property = lhs
        property.multiplier *= rhs
        property.dh *= rhs
        property.dw *= rhs
        return property
    }
    
    @_inlineable
    public static func / (lhs: LayoutSizeProperty, rhs: CGFloat) -> LayoutSizeProperty {
        return lhs * (1 / rhs)
    }
    
    @_versioned
    static func formConstraints(
        lhs: LayoutSizeProperty,
        rhs: LayoutSizeProperty,
        relation: LayoutConstraint.Relation
    ) -> LayoutSizeConstraints {
        let multiplier = rhs.multiplier / lhs.multiplier
        
        let width = LayoutConstraint(
            item:       lhs.item,
            attribute:  .width,
            relatedBy:  relation,
            toItem:     rhs.item,
            attribute:  .width,
            multiplier: multiplier,
            constant:   rhs.dw - lhs.dw
        )
        
        let height = LayoutConstraint(
            item:       lhs.item,
            attribute:  .height,
            relatedBy:  relation,
            toItem:     rhs.item,
            attribute:  .height,
            multiplier: multiplier,
            constant:   rhs.dh - lhs.dh
        )
        
        if let context = LayoutContext.current {
            context.addConstraint(width)
            context.addConstraint(height)
        }
        
        return LayoutSizeConstraints(width: width, height: height)
    }
    
    @_versioned
    func formConstraints(size: CGSize, relation: LayoutConstraint.Relation) -> LayoutSizeConstraints {
        let width = LayoutConstraint(
            item:       item,
            attribute:  .width,
            relatedBy:  relation,
            toItem:     nil,
            attribute: .notAnAttribute,
            multiplier: 0,
            constant:   (size.width - dw) / multiplier
        )
        
        let height = LayoutConstraint(
            item:       item,
            attribute:  .height,
            relatedBy:  relation,
            toItem:     nil,
            attribute:  .notAnAttribute,
            multiplier: 0,
            constant:   (size.height - dh) / multiplier
        )
        
        if let context = LayoutContext.current {
            context.addConstraint(width)
            context.addConstraint(height)
        }
        
        return LayoutSizeConstraints(width: width, height: height)
    }
}
