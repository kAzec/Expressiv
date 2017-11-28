//
//  Layout.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

@discardableResult
public func layout(activates: Bool = true, action: () -> Void) -> [LayoutConstraint] {
    LayoutContext.begin()
    action()
    return LayoutContext.end(activates: activates)
}

@discardableResult
public func layout<A : LayoutTarget>( _ a: A, activates: Bool = true, action: (A.LayoutProxyType) -> ())
    -> [LayoutConstraint]
{
    LayoutContext.begin()
    action(a.makeLayoutProxy())
    return LayoutContext.end(activates: activates)
}

@discardableResult
public func layout<A : LayoutTarget, B : LayoutTarget>(
    _ a: A, _ b: B,
    activates: Bool = true,
    action: (A.LayoutProxyType, B.LayoutProxyType) -> ()
) -> [LayoutConstraint]
{
    LayoutContext.begin()
    action(a.makeLayoutProxy(), b.makeLayoutProxy())
    return LayoutContext.end(activates: activates)
}

@discardableResult
public func layout<A : LayoutTarget, B : LayoutTarget, C : LayoutTarget>(
    _ a: A, _ b: B, _ c: C,
    activates: Bool = true,
    action: (A.LayoutProxyType, B.LayoutProxyType, C.LayoutProxyType) -> ()
) -> [LayoutConstraint]
{
    LayoutContext.begin()
    action(a.makeLayoutProxy(), b.makeLayoutProxy(), c.makeLayoutProxy())
    return LayoutContext.end(activates: activates)
}

@discardableResult
public func layout<A : LayoutTarget, B : LayoutTarget, C : LayoutTarget, D : LayoutTarget>(
    _ a: A, _ b: B, _ c: C, _ d: D,
    activates: Bool = true,
    action: (A.LayoutProxyType, B.LayoutProxyType, C.LayoutProxyType, D.LayoutProxyType) -> ()
) -> [LayoutConstraint]
{
    LayoutContext.begin()
    action(a.makeLayoutProxy(), b.makeLayoutProxy(), c.makeLayoutProxy(), d.makeLayoutProxy())
    return LayoutContext.end(activates: activates)
}

@discardableResult
public func layout<A : LayoutTarget, B : LayoutTarget, C : LayoutTarget, D : LayoutTarget, E : LayoutTarget>(
    _ a: A, _ b: B, _ c: C, _ d: D, _ e: E,
    activates: Bool = true,
    action: (A.LayoutProxyType, B.LayoutProxyType, C.LayoutProxyType, D.LayoutProxyType, E.LayoutProxyType) -> ()
) -> [LayoutConstraint]
{
    LayoutContext.begin()
    action(a.makeLayoutProxy(), b.makeLayoutProxy(), c.makeLayoutProxy(), d.makeLayoutProxy(), e.makeLayoutProxy())
    return LayoutContext.end(activates: activates)
}

@discardableResult
public func layout<A : LayoutTarget, B : LayoutTarget, C : LayoutTarget, D : LayoutTarget, E : LayoutTarget, F : LayoutTarget>(
    _ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F,
    activates: Bool = true,
    action: (A.LayoutProxyType, B.LayoutProxyType, C.LayoutProxyType, D.LayoutProxyType, E.LayoutProxyType, F.LayoutProxyType) -> ()
) -> [LayoutConstraint]
{
    LayoutContext.begin()
    
    action(
        a.makeLayoutProxy(),
        b.makeLayoutProxy(),
        c.makeLayoutProxy(),
        d.makeLayoutProxy(),
        e.makeLayoutProxy(),
        f.makeLayoutProxy())
    
    return LayoutContext.end(activates: activates)
}

@discardableResult
public func layout<Target : LayoutTarget>(
    _ targets: [Target],
    activates: Bool = true,
    action: ([Target.LayoutProxyType]) -> ()
) -> [LayoutConstraint]
{
    LayoutContext.begin()
    action(targets.map { $0.makeLayoutProxy() })
    return LayoutContext.end(activates: activates)
}

@discardableResult
public func layout<Key, Target : LayoutTarget>(
    _ targets: [Key : Target],
    activates: Bool = true,
    action: ([Key : Target.LayoutProxyType]) -> ()
) -> [LayoutConstraint]
{
    LayoutContext.begin()
    action(targets.mapValues { $0.makeLayoutProxy() })
    return LayoutContext.end(activates: activates)
}
