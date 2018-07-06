//
//  LayoutSizeConstraint.swift
//  Expressiv
//
//  Created by Fengwei Liu on 2018/07/06.
//  Copyright © 2018 kAzec. All rights reserved.
//

import CoreGraphics

public struct LayoutSizeConstraints : LayoutCompoundConstraint {
    public let width: LayoutConstraint
    public let height: LayoutConstraint
    
    @_inlineable
    public var all: [LayoutConstraint] {
        return [width, height]
    }
    
    @_inlineable
    public var size: CGSize {
        get {
            return CGSize(width: width.constant, height: height.constant)
        }
        
        set {
            width.constant = newValue.width
            height.constant = newValue.height
        }
    }
    
    @_inlineable
    @discardableResult
    public static func ~ (lhs: LayoutSizeConstraints, rhs: LayoutConstraint.Priority) -> LayoutSizeConstraints {
        lhs.width.priority = rhs
        lhs.height.priority = rhs
        return lhs
    }
}
