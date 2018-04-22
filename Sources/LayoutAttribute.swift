//
//  LayoutAttribute.swift
//  Expressiv
//
//  Created by Fengwei Liu on 2018/04/21.
//  Copyright © 2018 kAzec. All rights reserved.
//

public protocol LayoutAttribute : RawRepresentable where RawValue == Int {
    var nsAttribute: LayoutConstraint.Attribute { get }
}

public protocol LayoutAxisAttribute : LayoutAttribute { }

public enum LayoutXAxisAttribute : Int, LayoutAxisAttribute {
    
    case left = 1
    
    case right = 2
    
    case leading = 5
    
    case trailing = 6
    
    case centerX = 9
    
    #if os(iOS) || os(tvOS)
    case leftMargin = 13
    
    case rightMargin = 14
    
    case leadingMargin = 17
    
    case trailingMargin = 18
    
    case centerXWithinMargins = 19
    #endif
    
    @_inlineable
    public var nsAttribute: LayoutConstraint.Attribute {
        return unsafeBitCast(rawValue, to: LayoutConstraint.Attribute.self)
    }
}

public enum LayoutYAxisAttribute : Int, LayoutAxisAttribute {
    
    case top = 3
    
    case bottom = 4
    
    case centerY = 10
    
    case lastBaseline = 11
    
    case firstBaseline = 12
    
    #if os(iOS) || os(tvOS)
    case topMargin = 15
    
    case bottomMargin = 16
    
    case centerYWithinMargins = 20
    #endif
    
    @_inlineable
    public var nsAttribute: LayoutConstraint.Attribute {
        return unsafeBitCast(rawValue, to: LayoutConstraint.Attribute.self)
    }
}

public enum LayoutDirectionalXAxisAttribute : Int {
    
    case leading = 5
    
    case trailing = 6
    
    #if os(iOS) || os(tvOS)
    case leadingMargin = 17
    
    case trailingMargin = 18
    #endif
    
    @_inlineable
    public var nsAttribute: LayoutConstraint.Attribute {
        return unsafeBitCast(rawValue, to: LayoutConstraint.Attribute.self)
    }
    
    @_inlineable
    public var xAttribute: LayoutXAxisAttribute {
        return unsafeBitCast(self, to: LayoutXAxisAttribute.self)
    }
}

public enum LayoutDimensionAttribute : Int {
    
    case width = 7
    
    case height = 8
    
    @_inlineable
    public var nsAttribute: LayoutConstraint.Attribute {
        return unsafeBitCast(rawValue, to: LayoutConstraint.Attribute.self)
    }
}
