//
//  Layout.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import Foundation

@discardableResult
public func layout<A, B>(_ a: A, _ b: B, block: (LayoutProxy<A>, LayoutProxy<B>) -> ()) -> LayoutConstraintGroup {
    let context = LayoutContext()
    block(LayoutProxy(a, context), LayoutProxy(b, context))
    let group = LayoutConstraintGroup(context.constraints)
    group.activateConstraints()
    return group
}

@discardableResult
public func layout<A, B, C>(_ a: A, _ b: B, _ c: C, block: (LayoutProxy<A>, LayoutProxy<B>, LayoutProxy<C>) -> ())
    -> LayoutConstraintGroup {
        
    let context = LayoutContext()
    block(LayoutProxy(a, context), LayoutProxy(b, context), LayoutProxy(c, context))
    let group = LayoutConstraintGroup(context.constraints)
    group.activateConstraints()
    return group
}

@discardableResult
public func layout<A, B, C, D>(_ a: A, _ b: B, _ c: C, _ d: D, block: (LayoutProxy<A>, LayoutProxy<B>, LayoutProxy<C>,
    LayoutProxy<D>) -> ()) -> LayoutConstraintGroup {
        
    let context = LayoutContext()
    block(LayoutProxy(a, context), LayoutProxy(b, context), LayoutProxy(c, context), LayoutProxy(d, context))
    let group = LayoutConstraintGroup(context.constraints)
    group.activateConstraints()
    return group
}

@discardableResult
public func layout<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, block: (LayoutProxy<A>, LayoutProxy<B>,
    LayoutProxy<C>, LayoutProxy<D>, LayoutProxy<E>) -> ()) -> LayoutConstraintGroup {
        
    let context = LayoutContext()
    block(LayoutProxy(a, context), LayoutProxy(b, context), LayoutProxy(c, context), LayoutProxy(d, context),
          LayoutProxy(e, context))
        
    let group = LayoutConstraintGroup(context.constraints)
    group.activateConstraints()
    return group
}

@discardableResult
public func layout<A, B, C, D, E, F> (_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, block: (LayoutProxy<A>,
    LayoutProxy<B>, LayoutProxy<C>, LayoutProxy<D>, LayoutProxy<E>, LayoutProxy<F>) -> ()) -> LayoutConstraintGroup {
        
    let context = LayoutContext()
    block(LayoutProxy(a, context), LayoutProxy(b, context), LayoutProxy(c, context), LayoutProxy(d, context),
          LayoutProxy(e, context), LayoutProxy(f, context))
    
    let group = LayoutConstraintGroup(context.constraints)
    group.activateConstraints()
    return group
}

@discardableResult
public func layout(_ views: [UIView], block: ([LayoutProxy<UIView>]) -> ()) -> LayoutConstraintGroup {
    let context =  LayoutContext()
    block(views.map { LayoutProxy($0, context) })
    let group = LayoutConstraintGroup(context.constraints)
    group.activateConstraints()
    return group
}

@discardableResult
public func layout<Key: Hashable>(_ viewDictionary: [Key : UIView], block: ([Key : LayoutProxy<UIView>]) -> ())
    -> LayoutConstraintGroup {
        
    let context = LayoutContext()
    var proxyDictionary = [Key : LayoutProxy<UIView>](minimumCapacity: viewDictionary.count)
        
    for (key, view) in viewDictionary {
        proxyDictionary[key] = LayoutProxy(view, context)
    }
    
    block(proxyDictionary)
    
    let group = LayoutConstraintGroup(context.constraints)
    group.activateConstraints()
    return group
}
