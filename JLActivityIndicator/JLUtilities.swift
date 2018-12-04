//
//  JLUtilities.swift
//  JLActivityIndicator
//
//  Created by Jing Wei Li on 12/3/18.
//  Copyright © 2018 Jing Wei Li. All rights reserved.
//

import Foundation

class JLUtilities {
    
    /**
     * Helper method to center a subview inside a superview through the use of
     * Autolayout constraints.
     * - parameter parentview: The parent view to center the `subivew` inside.
     * - parameter subview: The subvicew to be centered inside the `parentview`.
     */
    class func center(subview: UIView?, on parentview: UIView?) {
        guard let parentview = parentview, let subview = subview else { return }
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: subview, attribute: .centerX,
                                                      relatedBy: .equal, toItem: parentview,
                                                      attribute: .centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: subview, attribute: .centerY,
                                                    relatedBy: .equal, toItem: parentview,
                                                    attribute: .centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: subview, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute,
                                                 multiplier: 1, constant: subview.frame.width)
        let heightConstraint = NSLayoutConstraint(item: subview, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute,
                                                  multiplier: 1, constant: subview.frame.height)
        parentview.addConstraints([horizontalConstraint, verticalConstraint,
                                   widthConstraint, heightConstraint])
    }
}

