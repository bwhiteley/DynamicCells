//
//  UIView+DynamicCells.swift
//  DynamicCells
//
//  Created by Bart Whiteley on 10/11/14.
//  Copyright (c) 2014 Bart Whiteley. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func jbw_systemLayoutSizeFittingSize(targetSize:CGSize) -> CGSize {
        if self.respondsToSelector("systemLayoutSizeFittingSize:withHorizontalFittingPriority:verticalFittingPriority:") {
            let hp:UILayoutPriority = 1000 // linker errors if we use the symbolic name UILayoutPriorityRequired
            let vp:UILayoutPriority = 50  // linker errors if we use the symbolic name UILayoutPriorityFittingSizeLevel
            let sz = self.systemLayoutSizeFittingSize(targetSize, withHorizontalFittingPriority: hp, verticalFittingPriority: vp)
            return sz
        }
        else {
            let sz = self.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
            return sz
        }
    }
}
