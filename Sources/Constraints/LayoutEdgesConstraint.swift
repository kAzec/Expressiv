//
//  LayoutEdgesConstraint.swift
//  Expressiv
//
//  Created by Fengwei Liu on 2018/07/06.
//  Copyright © 2018 kAzec. All rights reserved.
//

public struct LayoutEdgesConstraints : LayoutCompoundConstraint {
    public let top: LayoutConstraint
    public let left: LayoutConstraint
    public let bottom: LayoutConstraint
    public let right: LayoutConstraint
    
    @_inlineable
    public var all: [LayoutConstraint] {
        return [top, left, bottom, right]
    }
    
    @_inlineable
    public var horizontal: [LayoutConstraint] {
        return [left, right]
    }
    
    @_inlineable
    public var vertical: [LayoutConstraint] {
        return [top, bottom]
    }
    
    @_inlineable
    public var insets: EdgeInsets {
        get {
            return EdgeInsets(
                top: top.constant,
                left: left.constant,
                bottom: -bottom.constant,
                right: -right.constant
            )
        }
        
        set {
            top.constant = newValue.top
            left.constant = newValue.left
            bottom.constant = -newValue.bottom
            right.constant = -newValue.right
        }
    }
    
    @_inlineable
    @discardableResult
    public static func ~ (lhs: LayoutEdgesConstraints, rhs: LayoutConstraint.Priority) -> LayoutEdgesConstraints {
        lhs.top.priority = rhs
        lhs.left.priority = rhs
        lhs.bottom.priority = rhs
        lhs.right.priority = rhs
        
        return lhs
    }
}
