//
//  LayoutConstraints.swift
//  Expressiv
//
//  Created by Fengwei Liu on 26/01/2018.
//  Copyright © 2018 kAzec. All rights reserved.
//

import CoreGraphics

public protocol LayoutCompoundConstraint {
    var all: [LayoutConstraint] { get }
    
    static func ~ (lhs: Self, rhs: LayoutConstraint.Priority) -> Self
}

public extension LayoutCompoundConstraint {
    func activate() {
        LayoutConstraint.activate(all)
    }
    
    func deactivate() {
        LayoutConstraint.deactivate(all)
    }
}

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

public struct LayoutDirectionalEdgesConstraints : LayoutCompoundConstraint {
    public let top: LayoutConstraint
    public let leading: LayoutConstraint
    public let bottom: LayoutConstraint
    public let trailing: LayoutConstraint
    
    @_inlineable
    public var all: [LayoutConstraint] {
        return [top, leading, bottom, trailing]
    }
    
    @_inlineable
    public var horizontal: [LayoutConstraint] {
        return [leading, trailing]
    }
    
    @_inlineable
    public var vertical: [LayoutConstraint] {
        return [top, bottom]
    }
    
#if os(iOS) || os(tvOS)
    @_inlineable
    @available(iOS 11.0, tvOS 11.0, *)
    public var insets: NSDirectionalEdgeInsets {
        get {
            return NSDirectionalEdgeInsets(
                top:      top.constant,
                leading:  leading.constant,
                bottom:   -bottom.constant,
                trailing: -trailing.constant
            )
        }
        
        set {
            top.constant = newValue.top
            leading.constant = newValue.leading
            bottom.constant = -newValue.bottom
            trailing.constant = -newValue.trailing
        }
    }
#endif
    
    @_inlineable
    @discardableResult
    public static func ~ (
        lhs: LayoutDirectionalEdgesConstraints,
        rhs: LayoutConstraint.Priority
    ) -> LayoutDirectionalEdgesConstraints {
        lhs.top.priority = rhs
        lhs.leading.priority = rhs
        lhs.bottom.priority = rhs
        lhs.trailing.priority = rhs
        
        return lhs
    }
}

extension Array : LayoutCompoundConstraint where Element == LayoutConstraint {
    public var all: [LayoutConstraint] {
        return self
    }
    
    @_inlineable
    @discardableResult
    public static func ~ (lhs: [LayoutConstraint], rhs: LayoutConstraint.Priority) -> [LayoutConstraint] {
        for constraint in lhs {
            constraint.priority = rhs
        }
        
        return lhs
    }
}
