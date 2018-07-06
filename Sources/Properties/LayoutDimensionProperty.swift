//
//  LayoutDimensionProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import CoreGraphics

public struct LayoutDimensionProperty : LayoutProperty {
    
    @_versioned
    enum Backing {
        case item(LayoutItem)
        case dimension(NSLayoutDimension)
    }
    
    @_versioned
    let backing: Backing
    
    public let attribute: LayoutDimensionAttribute
    
    public var multiplier: CGFloat = 1.0
    
    public var constant: CGFloat
    
    @_inlineable
    public init(item: LayoutItem, attribute: LayoutDimensionAttribute, constant: CGFloat) {
        self.backing = .item(item)
        self.attribute = attribute
        self.constant = constant
    }
    
    @_inlineable
    public init(between property: LayoutXAxisProperty, _ otherProperty: LayoutXAxisProperty) {
        let anchor = property.item.anchor(forXAxis: property.attribute)
        let otherAnchor = otherProperty.item.anchor(forXAxis: otherProperty.attribute)
        
        self.backing = .dimension(anchor.anchorWithOffset(to: otherAnchor))
        self.attribute = .width
        self.constant = property.constant - otherProperty.constant
    }
    
    @_inlineable
    public init(between property: LayoutYAxisProperty, _ otherProperty: LayoutYAxisProperty) {
        let anchor = property.item.anchor(forYAxis: property.attribute)
        let otherAnchor = otherProperty.item.anchor(forYAxis: otherProperty.attribute)
        
        self.backing = .dimension(anchor.anchorWithOffset(to: otherAnchor))
        self.attribute = .height
        self.constant = property.constant - otherProperty.constant
    }
    
    @_inlineable
    @discardableResult
    public static func == (lhs: LayoutDimensionProperty, rhs: LayoutDimensionProperty) -> LayoutConstraint {
        return formConstraint(lhs: lhs, rhs: rhs, relation: .equal)
    }
    
    @_inlineable
    @discardableResult
    public static func >= (lhs: LayoutDimensionProperty, rhs: LayoutDimensionProperty) -> LayoutConstraint {
        return formConstraint(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
    }
    
    @_inlineable
    @discardableResult
    public static func <= (lhs: LayoutDimensionProperty, rhs: LayoutDimensionProperty) -> LayoutConstraint {
        return formConstraint(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
    }
    
    @_inlineable
    @discardableResult
    public static func == (lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutConstraint {
        return lhs.formConstraint(constant: rhs, relation: .equal)
    }
    
    @_inlineable
    @discardableResult
    public static func >= (lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutConstraint {
        return lhs.formConstraint(constant: rhs, relation: .greaterThanOrEqual)
    }
    
    @_inlineable
    @discardableResult
    public static func <= (lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutConstraint {
        return lhs.formConstraint(constant: rhs, relation: .lessThanOrEqual)
    }
    
    @_inlineable
    public static func + (lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutDimensionProperty {
        var property = lhs
        property.constant += rhs
        
        return property
    }
    
    @_inlineable
    public static func - (lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutDimensionProperty {
        return lhs + (-rhs)
    }
    
    @_inlineable
    public static func * (lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutDimensionProperty {
        var property = lhs
        property.multiplier *= rhs
        property.constant *= rhs
        
        return property
    }
    
    @_inlineable
    public static func / (lhs: LayoutDimensionProperty, rhs: CGFloat) -> LayoutDimensionProperty {
        return lhs * (1 / rhs)
    }
    
    @_versioned
    static func formConstraint(
        lhs: LayoutDimensionProperty,
        rhs: LayoutDimensionProperty,
        relation: LayoutConstraint.Relation
    ) -> LayoutConstraint {
        let constraint: LayoutConstraint
        let multiplier = rhs.multiplier / lhs.multiplier
        let constant = (rhs.constant - lhs.constant) / lhs.multiplier
        
        switch (lhs.backing, rhs.backing) {
        case (.item(let lhsItem), .item(let rhsItem)):
            constraint = LayoutConstraint(
                item:       lhsItem,
                attribute:  lhs.attribute.nsAttribute,
                relatedBy:  relation,
                toItem:     rhsItem,
                attribute:  rhs.attribute.nsAttribute,
                multiplier: multiplier,
                constant:   constant
            )
        case (.item(let lhsItem), .dimension(let rhsDimension)):
            constraint = lhsItem.anchor(forDimension: lhs.attribute).constraint(
                by: relation,
                to: rhsDimension,
                constant: constant,
                multiplier: multiplier
            )
        case (.dimension(let lhsDimension), .item(let rhsItem)):
            constraint = lhsDimension.constraint(
                by: relation,
                to: rhsItem.anchor(forDimension: rhs.attribute),
                constant: constant,
                multiplier: multiplier
            )
        case (.dimension(let lhsDimension), .dimension(let rhsDimension)):
            constraint = lhsDimension.constraint(
                by: relation,
                to: rhsDimension,
                constant: constant,
                multiplier: multiplier
            )
        }
        
        LayoutContext.current?.addConstraint(constraint)
        return constraint
    }
    
    @_versioned
    func formConstraint(constant: CGFloat, relation: LayoutConstraint.Relation) -> LayoutConstraint {
        let constraint: LayoutConstraint
        let constant = (constant - self.constant) / multiplier
        
        switch backing {
        case .item(let item):
            constraint = LayoutConstraint(
                item:       item,
                attribute:  attribute.nsAttribute,
                relatedBy:  relation,
                toItem:     nil,
                attribute:  .notAnAttribute,
                multiplier: 0,
                constant:   constant
            )
        case .dimension(let dimension):
            constraint = dimension.constraint(by: relation, to: constant)
        }
        
        LayoutContext.current?.addConstraint(constraint)
        return constraint
    }
}

private extension NSLayoutDimension {
    func constraint(
        by relation: LayoutConstraint.Relation,
        to anchor: NSLayoutDimension,
        constant: CGFloat,
        multiplier: CGFloat
    ) -> LayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalTo: anchor, multiplier: multiplier, constant: constant)
        case .greaterThanOrEqual:
            return constraint(
                greaterThanOrEqualTo: anchor,
                multiplier: multiplier,
                constant: constant
            )
        case .lessThanOrEqual:
            return constraint(
                lessThanOrEqualTo: anchor,
                multiplier: multiplier,
                constant: constant
            )
        }
    }
    
    func constraint(
        by relation: LayoutConstraint.Relation,
        to constant: CGFloat
    ) -> LayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalToConstant: constant)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualToConstant: constant)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualToConstant: constant)
        }
    }
}
