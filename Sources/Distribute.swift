//
//  Distribute.swift
//  Expressiv
//
//  Created by Fengwei Liu on 12/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import Foundation

public enum DistributionMode {
    case horizontally, vertically, leadingToTrailing
}

public func distribute<Views : Sequence>(_ views: Views, _ mode: DistributionMode, by spacing: CGFloat)
    -> [NSLayoutConstraint] where Views.Iterator.Element == LayoutProxy<UIView> {
    
        var iterator = views.makeIterator()
        
        if var previousView = iterator.next() {
            
            let combine: (_ previous: LayoutProxy<UIView>, _ next: LayoutProxy<UIView>) -> NSLayoutConstraint
            switch mode {
            case .horizontally:
                combine = { $0.right == $1.left - spacing }
            case .vertically:
                combine = { $0.bottom == $1.top - spacing }
            case .leadingToTrailing:
                combine = { $0.trailing == $1.leading - spacing }
            }
            
            var formedConstraints = [NSLayoutConstraint]()
            while let nextView = iterator.next() {
                formedConstraints.append(combine(previousView, nextView))
                previousView = nextView
            }
            
            return formedConstraints
        } else {
            return []
        }
}
