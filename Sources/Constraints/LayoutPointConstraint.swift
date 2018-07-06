//
//  LayoutPointConstraint.swift
//  Expressiv
//
//  Created by Fengwei Liu on 2018/07/06.
//  Copyright © 2018 kAzec. All rights reserved.
//

import CoreGraphics

public struct LayoutPointConstraints : LayoutCompoundConstraint {
    public let x: LayoutConstraint
    public let y: LayoutConstraint
    
    @_inlineable
    public var all: [LayoutConstraint] {
        return [x, y]
    }
    
    @_inlineable
    public var offset: CGPoint {
        get {
            return CGPoint(x: x.constant, y: y.constant)
        }
        
        set {
            x.constant = newValue.x
            y.constant = newValue.y
        }
    }
    
    @_inlineable
    @discardableResult
    public static func ~ (lhs: LayoutPointConstraints, rhs: LayoutConstraint.Priority) -> LayoutPointConstraints {
        lhs.x.priority = rhs
        lhs.y.priority = rhs
        return lhs
    }
}
