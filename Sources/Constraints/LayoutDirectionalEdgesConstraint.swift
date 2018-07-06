//
//  LayoutDirectionalEdgesConstraint.swift
//  Expressiv
//
//  Created by Fengwei Liu on 2018/07/06.
//  Copyright © 2018 kAzec. All rights reserved.
//

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

#if os(iOS) || os(tvOS)
import UIKit

public extension LayoutDirectionalEdgesConstraints {
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
}
#endif
