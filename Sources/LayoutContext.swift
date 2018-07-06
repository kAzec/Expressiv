//
//  LayoutContext.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

@_versioned
final class LayoutContext {
    private let previous: LayoutContext?
    private var constraints = [LayoutConstraint]()
    
    @inline(__always)
    private init(previous: LayoutContext?) {
        self.previous = previous
    }
    
    @inline(__always)
    func addConstraint(_ newConstraint: LayoutConstraint) {
        constraints.append(newConstraint)
    }
    
    @inline(__always)
    func addConstraints(_ newConstraints: [LayoutConstraint]) {
        constraints.append(contentsOf: newConstraints)
    }
}

// MARK: - Pushing/Poping Contexts

extension LayoutContext {
    private(set) static var current: LayoutContext?
    
    @_versioned
    static func push() -> LayoutContext {
        let context = LayoutContext(previous: current)
        current = context
        return context
    }
    
    @_versioned
    func pop(identifier: String?, exclusive: Bool) -> [LayoutConstraint] {
        if let identifier = identifier {
            var counter = 0
            
            for constraint in constraints where constraint.identifier == nil {
                constraint.identifier = "\(identifier):\(counter)"
                counter += 1
            }
        }
        
        if !exclusive, let previous = previous {
            previous.addConstraints(constraints)
        }
        
        return constraints
    }
}
