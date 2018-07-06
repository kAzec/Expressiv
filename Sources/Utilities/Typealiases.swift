//
//  Typealiases.swift
//  Expressiv
//
//  Created by Fengwei Liu on 27/11/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit
    
    public typealias View = UIView
    public typealias EdgeInsets = UIEdgeInsets
    public typealias LayoutGuide = UILayoutGuide
    public typealias LayoutConstraint = NSLayoutConstraint
    
    public extension LayoutConstraint {
        typealias Priority = UILayoutPriority
        typealias Relation = NSLayoutRelation
        typealias Attribute = NSLayoutAttribute
    }
#else
    import AppKit
    
    public typealias View = NSView
    public typealias EdgeInsets = NSEdgeInsets
    public typealias LayoutGuide = NSLayoutGuide
    public typealias LayoutConstraint = NSLayoutConstraint
#endif
