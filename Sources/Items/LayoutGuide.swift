//
//  LayoutGuide.swift
//  Expressiv
//
//  Created by Fengwei Liu on 2018/04/22.
//  Copyright © 2018 kAzec. All rights reserved.
//

extension LayoutGuide : LayoutItem {
    @inline(__always)
    public func prepareForLayoutProxy() { }
    
    @_inlineable
    public func anchor(forXAxis attribute: LayoutXAxisAttribute) -> NSLayoutXAxisAnchor {
        switch attribute {
    #if os(iOS) || os(tvOS)
        case .left, .leftMargin:
            return leftAnchor
        case .right, .rightMargin:
            return rightAnchor
        case .leading, .leadingMargin:
            return leadingAnchor
        case .trailing, .trailingMargin:
            return trailingAnchor
        case .centerX, .centerXWithinMargins:
            return centerXAnchor
    #else
        case .left:
            return leftAnchor
        case .right:
            return rightAnchor
        case .leading:
            return leadingAnchor
        case .trailing:
            return trailingAnchor
        case .centerX:
            return centerXAnchor
    #endif
        }
    }
    
    @_inlineable
    public func anchor(forYAxis attribute: LayoutYAxisAttribute) -> NSLayoutYAxisAnchor {
        switch attribute {
    #if os(iOS) || os(tvOS)
        case .top, .topMargin, .firstBaseline:
            return topAnchor
        case .bottom, .bottomMargin, .lastBaseline:
            return bottomAnchor
        case .centerY, .centerYWithinMargins:
            return centerYAnchor
    #else
        case .top, .firstBaseline:
            return topAnchor
        case .bottom, .lastBaseline:
            return bottomAnchor
        case .centerY:
            return centerYAnchor
    #endif
        }
    }
    
    @_inlineable
    public func anchor(forDimension attribute: LayoutDimensionAttribute) -> NSLayoutDimension {
        switch attribute {
        case .width:
            return widthAnchor
        case .height:
            return heightAnchor
        }
    }
}
