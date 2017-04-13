//
//  LayoutProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import Foundation

public protocol LayoutProperty {
    
    static func ==(lhs: Self, rhs: Self) -> NSLayoutConstraint
    static func >=(lhs: Self, rhs: Self) -> NSLayoutConstraint
    static func <=(lhs: Self, rhs: Self) -> NSLayoutConstraint
}

public protocol LayoutCompoundProperty {
    
    static func ==(lhs: Self, rhs: Self) -> [NSLayoutConstraint]
    static func >=(lhs: Self, rhs: Self) -> [NSLayoutConstraint]
    static func <=(lhs: Self, rhs: Self) -> [NSLayoutConstraint]
}
