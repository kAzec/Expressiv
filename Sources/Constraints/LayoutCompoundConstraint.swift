//
//  LayoutConstraints.swift
//  Expressiv
//
//  Created by Fengwei Liu on 26/01/2018.
//  Copyright © 2018 kAzec. All rights reserved.
//

public protocol LayoutCompoundConstraint {
    var all: [LayoutConstraint] { get }
    
    static func ~ (lhs: Self, rhs: LayoutConstraint.Priority) -> Self
}

public extension LayoutCompoundConstraint {
    @_inlineable
    func activate() {
        LayoutConstraint.activate(all)
    }
    
    @_inlineable
    func deactivate() {
        LayoutConstraint.deactivate(all)
    }
}

extension Array : LayoutCompoundConstraint where Element == LayoutConstraint {
    public var all: [LayoutConstraint] {
        @inline(__always)
        get { return self }
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
