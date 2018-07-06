//
//  Layout.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

@_inlineable
public func layout(
    _ identifier: String? = nil,
    exclusive: Bool = false,
    action: () -> Void
) -> [LayoutConstraint] {
    let context = LayoutContext.push()
    action()
    return context.pop(identifier: identifier, exclusive: exclusive)
}

@_inlineable
public func layout<A>(
    _ identifier: String? = nil,
    _ a: A,
    exclusive: Bool = false,
    action: (LayoutProxy<A>) -> ()
) -> [LayoutConstraint] {
    let context = LayoutContext.push()
    action(LayoutProxy(preparing: a))
    return context.pop(identifier: identifier, exclusive: exclusive)
}

@_inlineable
public func layout<A, B>(
    _ identifier: String? = nil,
    _ a: A, _ b: B,
    exclusive: Bool = false,
    action: (LayoutProxy<A>, LayoutProxy<B>) -> ()
) -> [LayoutConstraint] {
    let context = LayoutContext.push()
    action(LayoutProxy(preparing: a), LayoutProxy(preparing: b))
    return context.pop(identifier: identifier, exclusive: exclusive)
}

@_inlineable
public func layout<A, B, C>(
    _ identifier: String? = nil,
    _ a: A, _ b: B, _ c: C,
    exclusive: Bool = false,
    action: (LayoutProxy<A>, LayoutProxy<B>, LayoutProxy<C>) -> ()
) -> [LayoutConstraint] {
    let context = LayoutContext.push()
    action(LayoutProxy(preparing: a), LayoutProxy(preparing: b), LayoutProxy(preparing: c))
    return context.pop(identifier: identifier, exclusive: exclusive)
}

@_inlineable
public func layout<A, B, C, D>(
    _ identifier: String? = nil,
    _ a: A, _ b: B, _ c: C, _ d: D,
    exclusive: Bool = false,
    action: (LayoutProxy<A>, LayoutProxy<B>, LayoutProxy<C>, LayoutProxy<D>) -> ()
) -> [LayoutConstraint] {
    let context = LayoutContext.push()
    action(LayoutProxy(preparing: a), LayoutProxy(preparing: b), LayoutProxy(preparing: c), LayoutProxy(preparing: d))
    return context.pop(identifier: identifier, exclusive: exclusive)
}

@_inlineable
public func layout<A, B, C, D, E>(
    _ identifier: String? = nil,
    _ a: A, _ b: B, _ c: C, _ d: D, _ e: E,
    exclusive: Bool = false,
    action: (LayoutProxy<A>, LayoutProxy<B>, LayoutProxy<C>, LayoutProxy<D>, LayoutProxy<E>) -> ()
) -> [LayoutConstraint] {
    let context = LayoutContext.push()
    
    action(
        LayoutProxy(preparing: a),
        LayoutProxy(preparing: b),
        LayoutProxy(preparing: c),
        LayoutProxy(preparing: d),
        LayoutProxy(preparing: e)
    )
    
    return context.pop(identifier: identifier, exclusive: exclusive)
}

@_inlineable
public func layout<A, B, C, D, E, F>(
    _ identifier: String? = nil,
    _ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F,
    exclusive: Bool = false,
    action: (LayoutProxy<A>, LayoutProxy<B>, LayoutProxy<C>, LayoutProxy<D>, LayoutProxy<E>, LayoutProxy<F>) -> ()
) -> [LayoutConstraint] {
    let context = LayoutContext.push()
    
    action(
        LayoutProxy(preparing: a),
        LayoutProxy(preparing: b),
        LayoutProxy(preparing: c),
        LayoutProxy(preparing: d),
        LayoutProxy(preparing: e),
        LayoutProxy(preparing: f)
    )
    
    return context.pop(identifier: identifier, exclusive: exclusive)
}

@_inlineable
public func layout<Target>(
    _ identifier: String? = nil,
    _ targets: [Target],
    exclusive: Bool = false,
    action: ([LayoutProxy<Target>]) -> ()
) -> [LayoutConstraint] {
    let context = LayoutContext.push()
    action(targets.map { LayoutProxy(preparing: $0) })
    return context.pop(identifier: identifier, exclusive: exclusive)
}

@_inlineable
public func layout<Key, Target>(
    _ identifier: String? = nil,
    _ targets: [Key : Target],
    exclusive: Bool = false,
    action: ([Key : LayoutProxy<Target>]) -> ()
) -> [LayoutConstraint] {
    let context = LayoutContext.push()
    action(targets.mapValues { LayoutProxy(preparing: $0) })
    return context.pop(identifier: identifier, exclusive: exclusive)
}
