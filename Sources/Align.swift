//
//  Align.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import Foundation
import UIKit

private func align<P : LayoutProperty>(_ properties: [P], to target: P) -> [NSLayoutConstraint] {
    return properties.map { $0 == target }
}

@discardableResult
public func alignLeft(of views: [LayoutProxy<UIView>], to target: LayoutXAxisProperty) -> [NSLayoutConstraint] {
    return align(views.map { $0.left }, to: target)
}

@discardableResult
public func alignRight(of views: [LayoutProxy<UIView>], to target: LayoutXAxisProperty) -> [NSLayoutConstraint] {
    return align(views.map { $0.right }, to: target)
}

@discardableResult
public func alignTop(of views: [LayoutProxy<UIView>], to target: LayoutYAxisProperty) -> [NSLayoutConstraint] {
    return align(views.map { $0.top }, to: target)
}

@discardableResult
public func alignBottom(of views: [LayoutProxy<UIView>], to target: LayoutYAxisProperty) -> [NSLayoutConstraint] {
    return align(views.map { $0.bottom }, to: target)
}

@discardableResult
public func alignCenterX(of views: [LayoutProxy<UIView>], to target: LayoutXAxisProperty) -> [NSLayoutConstraint] {
    return align(views.map { $0.centerX }, to: target)
}

@discardableResult
public func alignCenterY(of views: [LayoutProxy<UIView>], to target: LayoutYAxisProperty) -> [NSLayoutConstraint] {
    return align(views.map { $0.centerY }, to: target)
}

@discardableResult
public func alignFirstBaseline(of views: [LayoutProxy<UIView>], to target: LayoutYAxisProperty) -> [NSLayoutConstraint] {
    return align(views.map { $0.firstBaseline }, to: target)
}

@discardableResult
public func alignLastBaseline(of views: [LayoutProxy<UIView>], to target: LayoutYAxisProperty) -> [NSLayoutConstraint] {
    return align(views.map { $0.lastBaseline }, to: target)
}
