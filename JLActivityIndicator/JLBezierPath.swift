//
//  JLBezierPath.swift
//  JLActivityIndicator
//
//  Created by Jing Wei Li on 8/23/18.
//  Copyright © 2018 Jing Wei Li. All rights reserved.
//

import Foundation

/**
 * A wrapper for the bezier path JLActivityIndicator uses. Customizable options include stroke width,
 * stroke color and the bezier path.
 */
public struct JLBezierPath {
    let strokeWidth: CGFloat
    let strokeColor: UIColor
    let strokePath: UIBezierPath
    
    /**
     * Initializer for the customizable path. All properties have default values. Can be initialized
     * with `let path = JLBezierPath()`.
     * - parameter strokeWidth: Width of the path. Defaults to 3.0
     * - parameter strokeColor: Color of the path. Defaults to lightGray.
     * - parameter strokePath: The bezier path the activity indicator's animation will draw. Defaults to a 60x60 circle.
     */
    public init (strokeWidth: CGFloat = 3.0,
                 strokeColor: UIColor = UIColor.lightGray,
                 strokePath: UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 60, height: 60))) {
        self.strokePath = strokePath
        self.strokeColor = strokeColor
        self.strokeWidth = strokeWidth
    }
}
