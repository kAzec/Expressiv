//
//  LayoutConstraintGroup.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import Foundation

public final class LayoutConstraintGroup {
    
    public private(set) var constraints: [NSLayoutConstraint]
    
    init(_ constraints: [NSLayoutConstraint]) {
        self.constraints = constraints
    }
    
    public convenience init() {
        self.init([])
    }
    
    public convenience init(first: LayoutConstraintGroup, rest: [LayoutConstraintGroup]) {
        self.init(rest.reduce(first.constraints, { $0 + $1.constraints }))
    }
    
    public convenience init(groups first: LayoutConstraintGroup, _ rest: LayoutConstraintGroup...) {
        self.init(first: first, rest: rest)
    }
    
    public func activateConstraints() {
        NSLayoutConstraint.activate(constraints)
    }
    
    public func deactivateConstraints() {
        NSLayoutConstraint.deactivate(constraints)
    }
    
    public func replaceConstraints(_ newConstraints: [NSLayoutConstraint]) {
        deactivateConstraints()
        constraints = newConstraints
        activateConstraints()
    }
    
    public func deactivateAndRemoveConstraints() {
        deactivateConstraints()
        constraints.removeAll()
    }
    
    public func setPriority(_ priority: UILayoutPriority) {
        constraints.forEach { $0.priority = priority }
    }
}
