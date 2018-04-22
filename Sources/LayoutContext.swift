//
//  LayoutContext.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

@_versioned
final class LayoutContext {
    private static var stack = [LayoutContext]()
    
    private(set) static var current: LayoutContext?
    
    private var constraints = [LayoutConstraint]()
    
    func capture(_ constraint: LayoutConstraint) {
        constraints.append(constraint)
    }
    
    func capture(_ constraints: [LayoutConstraint]) {
        self.constraints += constraints
    }
    
    @_versioned
    static func push() {
        let context = LayoutContext()
        stack.append(context)
        current = context
    }
    
    @_versioned
    static func pop(activates: Bool) -> [LayoutConstraint] {
        assert(current != nil, "No previous layout context.")
        
        current = nil
        let constraints = stack.removeLast().constraints
        
        if activates {
            LayoutConstraint.activate(constraints)
        }
        
        return constraints
    }
}
