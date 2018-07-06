//
//  LayoutProxy.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

@_fixed_layout
public struct LayoutProxy<Item : LayoutItem> : LayoutProxyProtocol {
    public let item: Item
    
    @_inlineable
    public var base: LayoutItem {
        return item
    }
    
    @inline(__always)
    public init(_ item: Item) {
        self.item = item
    }
    
    @inline(__always)
    public init(preparing item: Item) {
        item.prepareForLayoutProxy()
        self.item = item
    }
}

public extension LayoutProxy {
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
    var center: LayoutPointProperty {
        return point(x: .centerX, y: .centerY)
    }
    
    @_inlineable
    var size: LayoutSizeProperty {
        return LayoutSizeProperty(item: item)
    }
    
    @_inlineable
    var edges: LayoutEdgesProperty {
        return edges(top: .top, left: .left, bottom: .bottom, right: .right)
    }
    
    @_inlineable
    var directionalEdges: LayoutDirectionalEdgesProperty {
        return edges(top: .top, leading: .leading, bottom: .bottom, trailing: .trailing)
    }
}

public extension LayoutProxy {
    @_inlineable
    func axis<Attribute>(_ attribute: Attribute) -> LayoutAxisProperty<Attribute> {
        return LayoutAxisProperty(item: item, attribute: attribute, constant: 0.0)
    }
    
    @_inlineable
    func dimension(_ attribute: LayoutDimensionAttribute) -> LayoutDimensionProperty {
        return LayoutDimensionProperty(item: item, attribute: attribute, constant: 0.0)
    }
    
    @_inlineable
    func point(x xAttribute: LayoutXAxisAttribute, y yAttribute: LayoutYAxisAttribute) -> LayoutPointProperty {
        return LayoutPointProperty(item: item, x: xAttribute, y: yAttribute)
    }
    
    @_inlineable
    func edges(
        top topAttribute: LayoutYAxisAttribute,
        left leftAttribute: LayoutXAxisAttribute,
        bottom bottomAttribute: LayoutYAxisAttribute,
        right rightAttribute: LayoutXAxisAttribute
    ) -> LayoutEdgesProperty {
        return LayoutEdgesProperty(
            item:   item,
            top:    topAttribute,
            left:   leftAttribute,
            bottom: bottomAttribute,
            right:  rightAttribute
        )
    }
    
    @_inlineable
    func edges(
        top topAttribute: LayoutYAxisAttribute,
        leading leadingAttribute: LayoutDirectionalAttribute,
        bottom bottomAttribute: LayoutYAxisAttribute,
        trailing trailingAttribute: LayoutDirectionalAttribute
    ) -> LayoutDirectionalEdgesProperty {
        return LayoutDirectionalEdgesProperty(
            item:     item,
            top:      topAttribute,
            leading:  leadingAttribute,
            bottom:   bottomAttribute,
            trailing: trailingAttribute
        )
    }
}

// MARK: - View Layout Proxy

public extension LayoutProxy where Item : View {
    @_inlineable
    var superview: LayoutProxy<View>? {
        if let superview = item.superview {
            return .init(preparing: superview)
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
    
    @available(iOS 11.0, tvOS 11.0, *)
    @_inlineable
    var safeArea: LayoutProxy<LayoutGuide> {
        return LayoutProxy<LayoutGuide>(preparing: item.safeAreaLayoutGuide)
    }
}

#if os(iOS) || os(tvOS)
public extension LayoutProxy where Item : View {
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
    
    @_inlineable
    var layoutMargins: LayoutProxy<LayoutGuide> {
        return LayoutProxy<LayoutGuide>(preparing: item.layoutMarginsGuide)
    }
    
    @_inlineable
    var readableContent: LayoutProxy<LayoutGuide> {
        return LayoutProxy<LayoutGuide>(preparing: item.readableContentGuide)
    }
}

// MARK: - Scroll View Layout Proxy

@available(iOS 11.0, tvOS 11.0, *)
public extension LayoutProxy where Item : UIScrollView {
    @_inlineable
    var content: LayoutProxy<LayoutGuide> {
        return LayoutProxy<LayoutGuide>(preparing: item.contentLayoutGuide)
    }
    
    @_inlineable
    var frame: LayoutProxy<LayoutGuide> {
        return LayoutProxy<LayoutGuide>(preparing: item.frameLayoutGuide)
    }
}
#endif

// MARK: - Layout Guide Layout Proxy

public extension LayoutProxy where Item : LayoutGuide {
    @_inlineable
    var owningView: LayoutProxy<View>? {
        if let owningView = item.owningView {
            return .init(preparing: owningView)
        } else {
            return nil
        }
    }
}
