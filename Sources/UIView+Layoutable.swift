//
//  UIView+Layoutable.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import Foundation

extension UIView : Layoutable {  }

public extension LayoutProxy where Target == UIView {
    
    var superview: LayoutProxy<UIView>? {
        if let superview = target.superview {
            return LayoutProxy(superview, context)
        } else {
            return nil
        }
    }
    
    var left: LayoutXAxisProperty {
        return LayoutXAxisProperty(constant: 0, context: context, anchor: target.leftAnchor)
    }
    
    var right: LayoutXAxisProperty {
        return LayoutXAxisProperty(constant: 0, context: context, anchor: target.rightAnchor)
    }
    
    var top: LayoutYAxisProperty {
        return LayoutYAxisProperty(constant: 0, context: context, anchor: target.topAnchor)
    }
    
    var bottom: LayoutYAxisProperty {
        return LayoutYAxisProperty(constant: 0, context: context, anchor: target.bottomAnchor)
    }
    
    var leading: LayoutXAxisProperty {
        return LayoutXAxisProperty(constant: 0, context: context, anchor: target.leadingAnchor)
    }
    
    var trailing: LayoutXAxisProperty {
        return LayoutXAxisProperty(constant: 0, context: context, anchor: target.trailingAnchor)
    }
    
    var width: LayoutDimensionProperty {
        return LayoutDimensionProperty(multiplier: 1, constant: 0, context: context, dimension: target.widthAnchor)
    }
    
    var height: LayoutDimensionProperty {
        return LayoutDimensionProperty(multiplier: 1, constant: 0, context: context, dimension: target.heightAnchor)
    }
    
    var center: LayoutCenterProperty {
        return LayoutCenterProperty(offset: (x: 0, y: 0), context: context, centerXAnchor: target.centerXAnchor,
                                    centerYAnchor: target.centerYAnchor)
    }
    
    var centerX: LayoutXAxisProperty {
        return LayoutXAxisProperty(constant: 0, context: context, anchor: target.centerXAnchor)
    }
    
    var centerY: LayoutYAxisProperty {
        return LayoutYAxisProperty(constant: 0, context: context, anchor: target.centerYAnchor)
    }
    
    var firstBaseline: LayoutYAxisProperty {
        return LayoutYAxisProperty(constant: 0, context: context, anchor: target.firstBaselineAnchor)
    }
    
    var lastBaseline: LayoutYAxisProperty {
        return LayoutYAxisProperty(constant: 0, context: context, anchor: target.lastBaselineAnchor)
    }
    
    var margins: LayoutProxy<UILayoutGuide> {
        return LayoutProxy<UILayoutGuide>(target.layoutMarginsGuide, context)
    }
    
    var readableContent: LayoutProxy<UILayoutGuide> {
        return LayoutProxy<UILayoutGuide>(target.readableContentGuide, context)
    }
}
