//
//  LayoutContext.swift
//  Expressiv
//
//  Created by Fengwei Liu on 09/04/2017.
//  Copyright © 2017 kAzec. All rights reserved.
//

import Foundation
import UIKit

final class LayoutContext {
    
    var constraints = [NSLayoutConstraint]()
    
    func captureConstraint(_ constraint: NSLayoutConstraint) {
        constraints.append(constraint)
    }
    
    func captureConstraints(_ constraints: [NSLayoutConstraint]) {
        self.constraints.append(contentsOf: constraints)
    }
}
