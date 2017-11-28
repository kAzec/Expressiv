//
//  Align.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

@discardableResult
public func align(_ attribute: LayoutConstraint.Attribute, of first: View, _ rest: View...) -> [LayoutConstraint] {
    let constraints = rest.reduce(into: [LayoutConstraint]()) { constraints, view in
        constraints.append(LayoutConstraint(item: first, attribute: attribute,
                                            relatedBy: .equal,
                                            toItem: view, attribute: attribute,
                                            multiplier: 1.0, constant: 0.0))
    }
    
    LayoutContext.current?.capture(constraints)
    return constraints
}

@discardableResult
public func align(_ attribute: LayoutConstraint.Attribute, of first: LayoutProxy<View>, _ rest: LayoutProxy<View>...)
    -> [LayoutConstraint]
{
    let first = first.target
    
    let constraints = rest.reduce(into: [LayoutConstraint]()) { constraints, proxy in
        constraints.append(LayoutConstraint(item: first, attribute: attribute,
                                            relatedBy: .equal,
                                            toItem: proxy.target, attribute: attribute,
                                            multiplier: 1.0, constant: 0.0))
    }
    
    LayoutContext.current?.capture(constraints)
    return constraints
}

@discardableResult
public func align(_ attribute: LayoutConstraint.Attribute, of views: [LayoutProxy<View>]) -> [LayoutConstraint] {
    var iterator = views.makeIterator()
    
    if let first = iterator.next() {
        let first = first.target
        var constraints = [LayoutConstraint]()
        
        while let next = iterator.next() {
            constraints.append(LayoutConstraint(item: first, attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: next.target, attribute: attribute,
                                                multiplier: 1.0, constant: 0.0))
        }
        
        LayoutContext.current?.capture(constraints)
        return constraints
    } else {
        return []
    }
}
