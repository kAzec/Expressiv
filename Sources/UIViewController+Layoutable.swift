//
//  UIViewController+Layoutable.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import Foundation

extension UIViewController : Layoutable {  }

public extension LayoutProxy where Target == UIViewController {
    
    var topGuideTop: LayoutYAxisProperty {
        return LayoutYAxisProperty(constant: 0, context: context, anchor: target.topLayoutGuide.topAnchor)
    }
    
    var topGuideBottom: LayoutYAxisProperty {
        return LayoutYAxisProperty(constant: 0, context: context, anchor: target.topLayoutGuide.bottomAnchor)
    }
    
    var topGuideHeight: LayoutDimensionProperty {
        return LayoutDimensionProperty(multiplier: 1, constant: 0, context: context, dimension: target.topLayoutGuide.heightAnchor)
    }
    
    var bottomGuideTop: LayoutYAxisProperty {
        return LayoutYAxisProperty(constant: 0, context: context, anchor: target.bottomLayoutGuide.topAnchor)
    }
    
    var bottomGuideBottom: LayoutYAxisProperty {
        return LayoutYAxisProperty(constant: 0, context: context, anchor: target.bottomLayoutGuide.bottomAnchor)
    }
    
    var bottomGuideHeight: LayoutDimensionProperty {
        return LayoutDimensionProperty(multiplier: 1, constant: 0, context: context, dimension: target.bottomLayoutGuide.heightAnchor)
    }
}
