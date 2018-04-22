//
//  LayoutProxy.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

public protocol AnyLayoutProxy {
    var base: LayoutItem { get }
}

public extension AnyLayoutProxy {
    @_inlineable
    var left: LayoutXAxisProperty {
        return axis(.left)
    }
    
    @_inlineable
    var right: LayoutXAxisProperty {
        return axis(.right)
    }
    
    @_inlineable
    var top: LayoutYAxisProperty {
        return axis(.top)
    }
    
    @_inlineable
    var bottom: LayoutYAxisProperty {
        return axis(.bottom)
    }
    
    @_inlineable
    var leading: LayoutXAxisProperty {
        return axis(.leading)
    }
    
    @_inlineable
    var trailing: LayoutXAxisProperty {
        return axis(.trailing)
    }
    
    @_inlineable
    var width: LayoutDimensionProperty {
        return dimension(.width)
    }
    
    @_inlineable
    var height: LayoutDimensionProperty {
        return dimension(.height)
    }
    
    @_inlineable
    var centerX: LayoutXAxisProperty {
        return axis(.centerX)
    }
    
    @_inlineable
    var centerY: LayoutYAxisProperty {
        return axis(.centerY)
    }
    
    @_inlineable
    func point(x xAttribute: LayoutXAxisAttribute, y yAttribute: LayoutYAxisAttribute) -> LayoutPointProperty {
        return LayoutPointProperty(item: base, x: xAttribute, y: yAttribute)
    }
    
    @_inlineable
    var center: LayoutPointProperty {
        return point(x: .centerX, y: .centerY)
    }
    
    @_inlineable
    var size: LayoutSizeProperty {
        return LayoutSizeProperty(item: base)
    }
    
    @_inlineable
    func edges(
        top topAttribute: LayoutYAxisAttribute,
        left leftAttribute: LayoutXAxisAttribute,
        bottom bottomAttribute: LayoutYAxisAttribute,
        right rightAttribute: LayoutXAxisAttribute
    ) -> LayoutEdgesProperty {
        return LayoutEdgesProperty(
            item: base,
            top: topAttribute,
            left: leftAttribute,
            bottom: bottomAttribute,
            right: rightAttribute
        )
    }
    
    @_inlineable
    func edges(
        top topAttribute: LayoutYAxisAttribute,
        leading leadingAttribute: LayoutDirectionalXAxisAttribute,
        bottom bottomAttribute: LayoutYAxisAttribute,
        trailing trailingAttribute: LayoutDirectionalXAxisAttribute
    ) -> LayoutDirectionalEdgesProperty {
        return LayoutDirectionalEdgesProperty(
            item: base,
            top: topAttribute,
            leading: leadingAttribute,
            bottom: bottomAttribute,
            trailing: trailingAttribute
        )
    }
    
    @_inlineable
    var edges: LayoutEdgesProperty {
        return edges(top: .top, left: .left, bottom: .bottom, right: .right)
    }
    
    @_inlineable
    var directionalEdges: LayoutDirectionalEdgesProperty {
        return edges(top: .top, leading: .leading, bottom: .bottom, trailing: .trailing)
    }
    
    #if os(iOS) || os(tvOS)
    @_inlineable
    var leftMargin: LayoutXAxisProperty {
        return axis(.leftMargin)
    }
    
    @_inlineable
    var rightMargin: LayoutXAxisProperty {
        return axis(.rightMargin)
    }
    
    @_inlineable
    var topMargin: LayoutYAxisProperty {
        return axis(.topMargin)
    }
    
    @_inlineable
    var bottomMargin: LayoutYAxisProperty {
        return axis(.bottomMargin)
    }
    
    @_inlineable
    var leadingMargin: LayoutXAxisProperty {
        return axis(.leadingMargin)
    }
    
    @_inlineable
    var trailingMargin: LayoutXAxisProperty {
        return axis(.trailingMargin)
    }
    
    @_inlineable
    var centerXWithinMargins: LayoutXAxisProperty {
        return axis(.centerXWithinMargins)
    }
    
    @_inlineable
    var centerYWithinMargins: LayoutYAxisProperty {
        return axis(.centerYWithinMargins)
    }
    
    @_inlineable
    var centerWithinMargins: LayoutPointProperty {
        return point(x: .centerXWithinMargins, y: .centerYWithinMargins)
    }
    
    @_inlineable
    var edgesWithinMargins: LayoutEdgesProperty {
        return edges(top: .topMargin, left: .leftMargin, bottom: .bottomMargin, right: .rightMargin)
    }
    
    @_inlineable
    var directionalEdgesWithinMargins: LayoutDirectionalEdgesProperty {
        return edges(
            top:      .topMargin,
            leading:  .leadingMargin,
            bottom:   .bottomMargin,
            trailing: .trailingMargin
        )
    }
    #endif
}

extension AnyLayoutProxy {
    @_versioned
    func axis<Attribute>(_ attribute: Attribute) -> LayoutAxisProperty<Attribute> {
        return LayoutAxisProperty(item: base, attribute: attribute, constant: 0.0)
    }
    
    @_versioned
    func dimension(_ attribute: LayoutDimensionAttribute) -> LayoutDimensionProperty {
        return LayoutDimensionProperty(item: base, attribute: attribute, constant: 0.0)
    }
}

public struct LayoutProxy<Item : LayoutItem> : AnyLayoutProxy {
    public let item: Item
    
    public var base: LayoutItem {
        return item
    }
    
    @_inlineable
    public init(_ item: Item) {
        item.prepareForLayoutProxy()
        self.item = item
    }
}

public extension LayoutProxy where Item : View {
    @_inlineable
    var superview: LayoutProxy<View>? {
        if let superview = item.superview {
            return .init(superview)
        } else {
            return nil
        }
    }
    
    @_inlineable
    var firstBaseline: LayoutYAxisProperty {
        return axis(.firstBaseline)
    }
    
    @_inlineable
    var lastBaseline: LayoutYAxisProperty {
        return axis(.lastBaseline)
    }
    
    #if os(iOS) || os(tvOS)
    @_inlineable
    @available(iOS 11.0, tvOS 11.0, *)
    var safeArea: LayoutProxy<LayoutGuide> {
        return .init(item.safeAreaLayoutGuide)
    }
    
    @_inlineable
    var layoutMargins: LayoutProxy<LayoutGuide> {
        return .init(item.layoutMarginsGuide)
    }
    
    @_inlineable
    var readableContent: LayoutProxy<LayoutGuide> {
        return .init(item.readableContentGuide)
    }
    #endif
}

public extension LayoutProxy where Item : LayoutGuide {
    @_inlineable
    var owningView: LayoutProxy<View>? {
        if let owningView = item.owningView {
            return .init(owningView)
        } else {
            return nil
        }
    }
}
