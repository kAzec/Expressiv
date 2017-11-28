//
//  LayoutPriority.swift
//  Expressiv
//
//  Created by Fengwei Liu on 28/11/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

precedencegroup PriorityPrecedence {
    associativity: none
    higherThan: AssignmentPrecedence
    lowerThan: TernaryPrecedence
}

infix operator ~: PriorityPrecedence

public extension LayoutConstraint {
    @discardableResult
    public static func ~(lhs: LayoutConstraint, rhs: Priority) -> LayoutConstraint {
        lhs.priority = rhs
        return lhs
    }
}

public extension Array where Element == LayoutConstraint {
    @discardableResult
    static func ~(lhs: [LayoutConstraint], rhs: LayoutConstraint.Priority) -> [LayoutConstraint] {
        for constraint in lhs {
            constraint.priority = rhs
        }

        return lhs
    }
}

public struct LayoutConstraintPair {
    public let horizontal: LayoutConstraint
    public let vertical: LayoutConstraint
    
    public var all: [LayoutConstraint] {
        return [horizontal, vertical]
    }
    
    @discardableResult
    public static func ~(lhs: LayoutConstraintPair, rhs: LayoutConstraint.Priority) -> LayoutConstraintPair {
        lhs.horizontal.priority = rhs
        lhs.vertical.priority = rhs
        return lhs
    }
}

public struct LayoutConstraintGroup {
    public let top: LayoutConstraint
    public let leading: LayoutConstraint
    public let bottom: LayoutConstraint
    public let trailing: LayoutConstraint
    
    public var horizontal: [LayoutConstraint] {
        return [leading, trailing]
    }
    public var vertical: [LayoutConstraint] {
        return [top, bottom]
    }
    
    public var all: [LayoutConstraint] {
        return [top, leading, bottom, trailing]
    }
    
    @discardableResult
    public static func ~(lhs: LayoutConstraintGroup, rhs: LayoutConstraint.Priority) -> LayoutConstraintGroup {
        lhs.top.priority = rhs
        lhs.leading.priority = rhs
        lhs.bottom.priority = rhs
        lhs.trailing.priority = rhs
        return lhs
    }
}
