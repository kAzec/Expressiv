//
//  LayoutItem.swift
//  Expressiv
//
//  Created by Fengwei Liu on 27/11/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

public protocol LayoutItem : class {
    func prepareForLayoutProxy()
    
    func anchor(forXAxis attribute: LayoutXAxisAttribute) -> NSLayoutXAxisAnchor
    func anchor(forYAxis attribute: LayoutYAxisAttribute) -> NSLayoutYAxisAnchor
    func anchor(forDimension attribute: LayoutDimensionAttribute) -> NSLayoutDimension
}
