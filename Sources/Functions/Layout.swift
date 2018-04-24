//
//  Layout.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

@_inlineable
@discardableResult
public func layout(activates: Bool = true, action: () -> Void) -> [LayoutConstraint] {
    LayoutContext.push()
    action()
    return LayoutContext.pop(activates: activates)
}

@_inlineable
@discardableResult
public func layout<A : LayoutItem>(
    _ a: A,
    activates: Bool = true,
    action: (LayoutProxy<A>) -> ()
) -> [LayoutConstraint] {
    LayoutContext.push()
    action(LayoutProxy(preparing: a))
    return LayoutContext.pop(activates: activates)
}

@_inlineable
@discardableResult
public func layout<A : LayoutItem, B : LayoutItem>(
    _ a: A, _ b: B,
    activates: Bool = true,
    action: (LayoutProxy<A>, LayoutProxy<B>) -> ()
) -> [LayoutConstraint] {
    LayoutContext.push()
    action(LayoutProxy(preparing: a), LayoutProxy(preparing: b))
    return LayoutContext.pop(activates: activates)
}

@_inlineable
@discardableResult
public func layout<A : LayoutItem, B : LayoutItem, C : LayoutItem>(
    _ a: A, _ b: B, _ c: C,
    activates: Bool = true,
    action: (LayoutProxy<A>, LayoutProxy<B>, LayoutProxy<C>) -> ()
) -> [LayoutConstraint] {
    LayoutContext.push()
    action(LayoutProxy(preparing: a), LayoutProxy(preparing: b), LayoutProxy(preparing: c))
    return LayoutContext.pop(activates: activates)
}

@_inlineable
@discardableResult
public func layout<A : LayoutItem, B : LayoutItem, C : LayoutItem, D : LayoutItem>(
    _ a: A, _ b: B, _ c: C, _ d: D,
    activates: Bool = true,
    action: (LayoutProxy<A>, LayoutProxy<B>, LayoutProxy<C>, LayoutProxy<D>) -> ()
) -> [LayoutConstraint] {
    LayoutContext.push()
    action(LayoutProxy(preparing: a), LayoutProxy(preparing: b), LayoutProxy(preparing: c), LayoutProxy(preparing: d))
    return LayoutContext.pop(activates: activates)
}

@_inlineable
@discardableResult
public func layout<A : LayoutItem, B : LayoutItem, C : LayoutItem, D : LayoutItem, E : LayoutItem>(
    _ a: A, _ b: B, _ c: C, _ d: D, _ e: E,
    activates: Bool = true,
    action: (LayoutProxy<A>, LayoutProxy<B>, LayoutProxy<C>, LayoutProxy<D>, LayoutProxy<E>) -> ()
) -> [LayoutConstraint] {
    LayoutContext.push()
    
    action(
        LayoutProxy(preparing: a),
        LayoutProxy(preparing: b),
        LayoutProxy(preparing: c),
        LayoutProxy(preparing: d),
        LayoutProxy(preparing: e)
    )
    
    return LayoutContext.pop(activates: activates)
}

@_inlineable
@discardableResult
public func layout<A : LayoutItem, B : LayoutItem, C : LayoutItem, D : LayoutItem, E : LayoutItem, F : LayoutItem>(
    _ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F,
    activates: Bool = true,
    action: (LayoutProxy<A>, LayoutProxy<B>, LayoutProxy<C>, LayoutProxy<D>, LayoutProxy<E>, LayoutProxy<F>) -> ()
) -> [LayoutConstraint] {
    LayoutContext.push()
    
    action(
        LayoutProxy(preparing: a),
        LayoutProxy(preparing: b),
        LayoutProxy(preparing: c),
        LayoutProxy(preparing: d),
        LayoutProxy(preparing: e),
        LayoutProxy(preparing: f)
    )
    
    return LayoutContext.pop(activates: activates)
}

@_inlineable
@discardableResult
public func layout<Target : LayoutItem>(
    _ targets: [Target],
    activates: Bool = true,
    action: ([LayoutProxy<Target>]) -> ()
) -> [LayoutConstraint] {
    LayoutContext.push()
    action(targets.map { LayoutProxy(preparing: $0) })
    return LayoutContext.pop(activates: activates)
}

@_inlineable
@discardableResult
public func layout<Key, Target : LayoutItem>(
    _ targets: [Key : Target],
    activates: Bool = true,
    action: ([Key : LayoutProxy<Target>]) -> ()
) -> [LayoutConstraint] {
    LayoutContext.push()
    action(targets.mapValues { LayoutProxy(preparing: $0) })
    return LayoutContext.pop(activates: activates)
}
