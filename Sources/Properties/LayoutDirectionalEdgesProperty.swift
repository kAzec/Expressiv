//
//  LayoutDirectionalEdgesProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 26/01/2018.
//  Copyright © 2018 kAzec. All rights reserved.
//

import CoreGraphics

public struct LayoutDirectionalEdgesProperty : LayoutCompoundProperty {
    public typealias LayoutConstraints = LayoutDirectionalEdgesConstraints
    
    @_versioned
    let item: LayoutItem
    
    public var topInset: CGFloat = 0.0
    
    public var leadingInset: CGFloat = 0.0
    
    public var bottomInset: CGFloat = 0.0
    
    public var trailingInset: CGFloat = 0.0
    
#if os(iOS) || os(tvOS)
    @available(iOS 11.0, tvOS 11.0, *)
    public var insets: NSDirectionalEdgeInsets {
        get {
            return NSDirectionalEdgeInsets(
                top:      topInset,
                leading:  leadingInset,
                bottom:   bottomInset,
                trailing: trailingInset
            )
        }
        
        set {
            topInset = newValue.top
            leadingInset = newValue.leading
            bottomInset = newValue.bottom
            trailingInset = newValue.trailing
        }
    }
#endif
    
    public let topAttribute: LayoutYAxisAttribute
    
    public let leadingAttribute: LayoutDirectionalAttribute
    
    public let bottomAttribute: LayoutYAxisAttribute
    
    public let trailingAttribute: LayoutDirectionalAttribute
    
    @_inlineable
    public init(
        item: LayoutItem,
        top topAttribute: LayoutYAxisAttribute,
        leading leadingAttribute: LayoutDirectionalAttribute,
        bottom bottomAttribute: LayoutYAxisAttribute,
        trailing trailingAttribute: LayoutDirectionalAttribute
    ) {
        self.item = item
        self.topAttribute = topAttribute
        self.leadingAttribute = leadingAttribute
        self.bottomAttribute = bottomAttribute
        self.trailingAttribute = trailingAttribute
    }
    
    @_inlineable
    public var top: LayoutYAxisProperty {
        return LayoutYAxisProperty(item: item, attribute: topAttribute, constant: leadingInset)
    }
    
    @_inlineable
    public var leading: LayoutXAxisProperty {
        return LayoutXAxisProperty(item: item, attribute: leadingAttribute.xAttribute, constant: leadingInset)
    }
    
    @_inlineable
    public var bottom: LayoutYAxisProperty {
        return LayoutYAxisProperty(item: item, attribute: bottomAttribute, constant: -bottomInset)
    }
    
    @_inlineable
    public var trailing: LayoutXAxisProperty {
        return LayoutXAxisProperty(item: item, attribute: trailingAttribute.xAttribute, constant: -trailingInset)
    }
    
    @_inlineable
    @discardableResult
    public static func == (
        lhs: LayoutDirectionalEdgesProperty,
        rhs: LayoutDirectionalEdgesProperty
    ) -> LayoutDirectionalEdgesConstraints {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .equal)
    }
    
    @_inlineable
    @discardableResult
    public static func >= (
        lhs: LayoutDirectionalEdgesProperty,
        rhs: LayoutDirectionalEdgesProperty
    ) -> LayoutDirectionalEdgesConstraints {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
    }
    
    @_inlineable
    @discardableResult
    public static func <= (
        lhs: LayoutDirectionalEdgesProperty,
        rhs: LayoutDirectionalEdgesProperty
    ) -> LayoutDirectionalEdgesConstraints {
        return formConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
    }
    
    @_inlineable
    public func insetBy(
        top: CGFloat,
        leading: CGFloat,
        bottom: CGFloat,
        trailing: CGFloat
    ) -> LayoutDirectionalEdgesProperty {
        var property = self
        
        property.topInset += topInset
        property.leadingInset += leading
        property.bottomInset += bottom
        property.trailingInset += trailing
        
        return property
    }
    
    @_versioned
    static func formConstraints(
        lhs: LayoutDirectionalEdgesProperty,
        rhs: LayoutDirectionalEdgesProperty,
        relation: LayoutConstraint.Relation
    ) -> LayoutDirectionalEdgesConstraints {
        let top = LayoutConstraint(
            item:       lhs.item,
            attribute:  lhs.topAttribute.nsAttribute,
            relatedBy:  relation,
            toItem:     rhs.item,
            attribute:  rhs.topAttribute.nsAttribute,
            multiplier: 1.0,
            constant:   rhs.topInset - lhs.topInset
        )
        
        let leading = LayoutConstraint(
            item:       lhs.item,
            attribute:  lhs.leadingAttribute.nsAttribute,
            relatedBy:  relation,
            toItem:     rhs.item,
            attribute:  rhs.leadingAttribute.nsAttribute,
            multiplier: 1.0,
            constant:   rhs.leadingInset - lhs.leadingInset
        )
        
        let bottom = LayoutConstraint(
            item:       lhs.item,
            attribute:  lhs.bottomAttribute.nsAttribute,
            relatedBy:  relation,
            toItem:     rhs.item,
            attribute:  rhs.bottomAttribute.nsAttribute,
            multiplier: 1.0,
            constant:   lhs.bottomInset - rhs.bottomInset
        )
        
        let trailing = LayoutConstraint(
            item:       lhs.item,
            attribute:  lhs.trailingAttribute.nsAttribute,
            relatedBy:  relation,
            toItem:     rhs.item,
            attribute:  rhs.trailingAttribute.nsAttribute,
            multiplier: 1.0,
            constant:   lhs.trailingInset - rhs.trailingInset
        )
        
        if let context = LayoutContext.current {
            context.addConstraint(top)
            context.addConstraint(leading)
            context.addConstraint(bottom)
            context.addConstraint(trailing)
        }
        
        return LayoutDirectionalEdgesConstraints(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }
}
