//
//  View+LayoutItem.swift
//  Expressiv
//
//  Created by Fengwei Liu on 2018/04/22.
//  Copyright © 2018 kAzec. All rights reserved.
//

extension View : LayoutItem {
    @_inlineable
    public func prepareForLayoutProxy() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func anchor(forXAxis attribute: LayoutXAxisAttribute) -> NSLayoutXAxisAnchor {
        switch attribute {
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
    #if os(iOS) || os(tvOS)
        case .leftMargin:
            return layoutMarginsGuide.leftAnchor
        case .rightMargin:
            return layoutMarginsGuide.rightAnchor
        case .leadingMargin:
            return layoutMarginsGuide.leadingAnchor
        case .trailingMargin:
            return layoutMarginsGuide.trailingAnchor
        case .centerXWithinMargins:
            return layoutMarginsGuide.centerXAnchor
    #endif
        }
    }
    
    public func anchor(forYAxis attribute: LayoutYAxisAttribute) -> NSLayoutYAxisAnchor {
        switch attribute {
        case .top:
            return topAnchor
        case .bottom:
            return bottomAnchor
        case .centerY:
            return centerYAnchor
        case .lastBaseline:
            return lastBaselineAnchor
        case .firstBaseline:
            return firstBaselineAnchor
    #if os(iOS) || os(tvOS)
        case .topMargin:
            return layoutMarginsGuide.topAnchor
        case .bottomMargin:
            return layoutMarginsGuide.bottomAnchor
        case .centerYWithinMargins:
            return layoutMarginsGuide.centerYAnchor
    #endif
        }
    }
    
    public func anchor(forDimension attribute: LayoutDimensionAttribute) -> NSLayoutDimension {
        switch attribute {
        case .width:
            return widthAnchor
        case .height:
            return heightAnchor
        }
    }
}

