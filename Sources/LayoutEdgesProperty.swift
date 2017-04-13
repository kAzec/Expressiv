//
//  LayoutEdgesProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import Foundation

public struct LayoutEdgesProperty : LayoutCompoundProperty {
    
    public var insets: UIEdgeInsets
    
    let context: LayoutContext
    
    let leftAnchor: NSLayoutXAxisAnchor
    let rightAnchor: NSLayoutXAxisAnchor
    let topAnchor: NSLayoutYAxisAnchor
    let bottomAnchor: NSLayoutYAxisAnchor
    
    @discardableResult
    public static func ==(lhs: LayoutEdgesProperty, rhs: LayoutEdgesProperty) -> [NSLayoutConstraint] {
        let leftConstraint = lhs.leftAnchor.constraint(equalTo: rhs.leftAnchor,
                                                       constant: rhs.insets.left - lhs.insets.left)
        
        let rightConstraint = lhs.rightAnchor.constraint(equalTo: rhs.rightAnchor,
                                                         constant: lhs.insets.right - rhs.insets.right)
        
        let topConstraint = lhs.topAnchor.constraint(equalTo: rhs.topAnchor,
                                                     constant: lhs.insets.top - rhs.insets.top)
        
        let bottomConstraint = lhs.bottomAnchor.constraint(equalTo: rhs.bottomAnchor,
                                                           constant: rhs.insets.bottom - lhs.insets.bottom)

        let formedConstraints = [leftConstraint, rightConstraint, topConstraint, bottomConstraint]
        lhs.context.captureConstraints(formedConstraints)
        return formedConstraints
    }
    
    @discardableResult
    public static func >=(lhs: LayoutEdgesProperty, rhs: LayoutEdgesProperty) -> [NSLayoutConstraint] {
        let leftConstraint = lhs.leftAnchor.constraint(greaterThanOrEqualTo: rhs.leftAnchor,
                                                       constant: rhs.insets.left - lhs.insets.left)
        
        let rightConstraint = lhs.rightAnchor.constraint(greaterThanOrEqualTo: rhs.rightAnchor,
                                                         constant: lhs.insets.right - rhs.insets.right)
        
        let topConstraint = lhs.topAnchor.constraint(greaterThanOrEqualTo: rhs.topAnchor,
                                                     constant: lhs.insets.top - rhs.insets.top)
        
        let bottomConstraint = lhs.bottomAnchor.constraint(greaterThanOrEqualTo: rhs.bottomAnchor,
                                                           constant: rhs.insets.bottom - lhs.insets.bottom)
        
        let formedConstraints = [leftConstraint, rightConstraint, topConstraint, bottomConstraint]
        lhs.context.captureConstraints(formedConstraints)
        return formedConstraints
    }
    
    @discardableResult
    public static func <=(lhs: LayoutEdgesProperty, rhs: LayoutEdgesProperty) -> [NSLayoutConstraint] {
        let leftConstraint = lhs.leftAnchor.constraint(lessThanOrEqualTo: rhs.leftAnchor,
                                                       constant: rhs.insets.left - lhs.insets.left)
        
        let rightConstraint = lhs.rightAnchor.constraint(lessThanOrEqualTo: rhs.rightAnchor,
                                                         constant: lhs.insets.right - rhs.insets.right)
        
        let topConstraint = lhs.topAnchor.constraint(lessThanOrEqualTo: rhs.topAnchor,
                                                     constant: lhs.insets.top - rhs.insets.top)
        
        let bottomConstraint = lhs.bottomAnchor.constraint(lessThanOrEqualTo: rhs.bottomAnchor,
                                                           constant: rhs.insets.bottom - lhs.insets.bottom)
        
        let formedConstraints = [leftConstraint, rightConstraint, topConstraint, bottomConstraint]
        lhs.context.captureConstraints(formedConstraints)
        return formedConstraints
    }
    
    public func inset(left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat) -> LayoutEdgesProperty {
        var property = self
        let insets = UIEdgeInsets(top: property.insets.top - top, left: property.insets.left - left,
                                  bottom: property.insets.bottom - bottom, right: property.insets.right - right)
        
        property.insets = insets
        return property
    }
}
