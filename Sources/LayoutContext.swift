//
//  LayoutContext.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

final class LayoutContext {
    static var current: LayoutContext? = nil
    
    private var constraints = [LayoutConstraint]()
    
    func capture(_ constraint: LayoutConstraint) {
        constraints.append(constraint)
    }
    
    func capture(_ constraints: [LayoutConstraint]) {
        self.constraints.append(contentsOf: constraints)
    }
    
    static func begin() {
        assert(current == nil, "Previous layout context has not yes ended.")
        
        let context = LayoutContext()
        current = context
    }
    
    static func end(activates: Bool) -> [LayoutConstraint] {
        let constraints = current!.constraints
        current = nil
        
        if activates {
            LayoutConstraint.activate(constraints)
        }
        
        return constraints
    }
}
