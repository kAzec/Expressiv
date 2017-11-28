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
    static func ==(lhs: Self, rhs: Self) -> NSLayoutConstraint
    static func >=(lhs: Self, rhs: Self) -> NSLayoutConstraint
    static func <=(lhs: Self, rhs: Self) -> NSLayoutConstraint
}

public protocol LayoutCompoundProperty {
    associatedtype CompoundConstraint
    
    static func ==(lhs: Self, rhs: Self) -> CompoundConstraint
    static func >=(lhs: Self, rhs: Self) -> CompoundConstraint
    static func <=(lhs: Self, rhs: Self) -> CompoundConstraint
}
