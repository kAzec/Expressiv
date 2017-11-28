//
//  LayoutProxy.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

public struct LayoutProxy<Target : LayoutTarget> {
    public let target: Target
}

public extension LayoutProxy {
    var left: LayoutXAxisProperty {
        return axis(.left)
    }
    
    var right: LayoutXAxisProperty {
        return axis(.right)
    }
    
    var top: LayoutYAxisProperty {
        return axis(.top)
    }
    
    var bottom: LayoutYAxisProperty {
        return axis(.bottom)
    }
    
    var leading: LayoutXAxisProperty {
        return axis(.leading)
    }
    
    var trailing: LayoutXAxisProperty {
        return axis(.trailing)
    }
    
    var width: LayoutDimensionProperty {
        return dimension(.width)
    }
    
    var height: LayoutDimensionProperty {
        return dimension(.height)
    }
    
    var centerX: LayoutXAxisProperty {
        return axis(.centerX)
    }
    
    var centerY: LayoutYAxisProperty {
        return axis(.centerY)
    }
    
    func unsafePoint(x: LayoutConstraint.Attribute, y: LayoutConstraint.Attribute) -> LayoutPointProperty {
        return LayoutPointProperty(item: target, xAttribute: x, yAttribute: y, dx: 0.0, dy: 0.0)
    }
    
    var center: LayoutPointProperty {
        return unsafePoint(x: .centerX, y: .centerY)
    }
    
    var size: LayoutSizeProperty {
        return LayoutSizeProperty(item: target, dw: 0.0, dh: 0.0, multiplier: 1.0)
    }
    
    func unsafeEdges(
        top: LayoutConstraint.Attribute,
        left: LayoutConstraint.Attribute,
        bottom: LayoutConstraint.Attribute,
        right: LayoutConstraint.Attribute
    ) -> LayoutEdgesProperty
    {
        return LayoutEdgesProperty(
            item: target,
            insets: EdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
            topAttribute: top, leftAttribute: left, bottomAttribute: bottom, rightAttribute: right)
    }
    
    var edges: LayoutEdgesProperty {
        return unsafeEdges(top: .top, left: .leading, bottom: .bottom, right: .trailing)
    }
    
    #if os(iOS) || os(tvOS)
    var leftMargin: LayoutXAxisProperty {
        return axis(.leftMargin)
    }
    
    var rightMargin: LayoutXAxisProperty {
        return axis(.rightMargin)
    }
    
    var topMargin: LayoutYAxisProperty {
        return axis(.topMargin)
    }
    
    var bottomMargin: LayoutYAxisProperty {
        return axis(.bottomMargin)
    }
    
    var leadingMargin: LayoutXAxisProperty {
        return axis(.leadingMargin)
    }
    
    var trailingMargin: LayoutXAxisProperty {
        return axis(.trailingMargin)
    }
    
    var centerXWithinMargins: LayoutXAxisProperty {
        return axis(.centerXWithinMargins)
    }
    
    var centerYWithinMargins: LayoutYAxisProperty {
        return axis(.centerYWithinMargins)
    }
    
    var centerWithinMargins: LayoutPointProperty {
        return unsafePoint(x: .centerXWithinMargins, y: .centerYWithinMargins)
    }
    
    var edgesWithinMargins: LayoutEdgesProperty {
        return unsafeEdges(top: .topMargin, left: .leadingMargin, bottom: .bottomMargin, right: .trailingMargin)
    }
    #endif
    
    @inline(__always)
    private func axis<Axis>(_ attribute: LayoutConstraint.Attribute) -> LayoutAxisProperty<Axis> {
        return LayoutAxisProperty<Axis>(item: target, attribute: attribute, constant: 0.0)
    }
    
    @inline(__always)
    private func dimension(_ attribute: LayoutConstraint.Attribute) -> LayoutDimensionProperty {
        return LayoutDimensionProperty(item: target, attribute: attribute, multiplier: 1.0, constant: 0.0)
    }
}

public extension LayoutProxy where Target : View {
    var superview: LayoutProxy<View>? {
        return target.superview?.makeLayoutProxy()
    }
    
    var firstBaseline: LayoutYAxisProperty {
        return axis(.firstBaseline)
    }
    
    var lastBaseline: LayoutYAxisProperty {
        return axis(.lastBaseline)
    }
    
    #if os(iOS) || os(tvOS)
    @available(iOS 11.0, tvOS 11.0, *)
    var safeArea: LayoutProxy<LayoutGuide> {
        return target.safeAreaLayoutGuide.makeLayoutProxy()
    }
    
    var margins: LayoutProxy<LayoutGuide> {
        return target.layoutMarginsGuide.makeLayoutProxy()
    }
    
    var readableContent: LayoutProxy<LayoutGuide> {
        return target.readableContentGuide.makeLayoutProxy()
    }
    #endif
}

public extension LayoutProxy where Target : LayoutGuide {
    var owningView: LayoutProxy<View>? {
        return target.owningView?.makeLayoutProxy()
    }
}
