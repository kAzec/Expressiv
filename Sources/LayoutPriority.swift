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
    @_inlineable
    @discardableResult
    public static func ~(lhs: LayoutConstraint, rhs: Priority) -> LayoutConstraint {
        lhs.priority = rhs
        return lhs
    }
}
