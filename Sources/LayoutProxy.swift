//
//  LayoutProxy.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

public struct LayoutProxy<Item : LayoutItem> : AnyLayoutProxy {
    public let item: Item
    
    public var base: LayoutItem {
        return item
    }
    
    @_inlineable
    public init(_ item: Item) {
        self.item = item
    }
    
    @_inlineable
    public init(preparing item: Item) {
        item.prepareForLayoutProxy()
        self.item = item
    }
}

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
    
    #if os(iOS) || os(tvOS)
    @_inlineable
    @available(iOS 11.0, tvOS 11.0, *)
    var safeArea: LayoutProxy<LayoutGuide> {
        return .init(preparing: item.safeAreaLayoutGuide)
    }
    
    @_inlineable
    var layoutMargins: LayoutProxy<LayoutGuide> {
        return .init(preparing: item.layoutMarginsGuide)
    }
    
    @_inlineable
    var readableContent: LayoutProxy<LayoutGuide> {
        return .init(preparing: item.readableContentGuide)
    }
    #endif
}

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
