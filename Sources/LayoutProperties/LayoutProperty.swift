//
//  LayoutProperty.swift
//  Expressiv
//
//  Created by Fengwei Liu on 27/11/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

public protocol LayoutProperty {
    static func ==(lhs: Self, rhs: Self) -> LayoutConstraint
    static func >=(lhs: Self, rhs: Self) -> LayoutConstraint
    static func <=(lhs: Self, rhs: Self) -> LayoutConstraint
}

public protocol LayoutCompoundProperty {
    associatedtype LayoutConstraints
    
    static func ==(lhs: Self, rhs: Self) -> LayoutConstraints
    static func >=(lhs: Self, rhs: Self) -> LayoutConstraints
    static func <=(lhs: Self, rhs: Self) -> LayoutConstraints
}
