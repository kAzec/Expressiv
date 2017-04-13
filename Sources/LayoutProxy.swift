//
//  LayoutProxy.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import Foundation
import UIKit

public struct LayoutProxy<Target : Layoutable> {
    
    let target: Target
    let context: LayoutContext
    
    init(_ target: Target, _ context: LayoutContext) {
        self.target = target
        self.context = context
        
        if let view = target as? UIView {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

func test(view: UIView, view2: UIView) {
    layout(view, view2) { v1, v2 in
        v1.left == v2.centerX + 10
    }
}
