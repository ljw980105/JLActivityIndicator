//
//  JLActivityIndicator.swift
//  JLActivityIndicator
//
//  Created by Jing Wei Li on 8/4/18.
//  Copyright © 2018 Jing Wei Li. All rights reserved.
//

import UIKit

public class JLActivityIndicator: UIView {
    private var spinner: ActivityIndicating = PathSpinner()
    private var startedSpinning = false
    
    /** An array of paths the activity indicator's drawings will follow. Make sure the encapsulated path object is containied within a rectangle defined by the size property. Only applies to the path mode.
     */
    public var paths: [JLBezierPath] = [JLBezierPath()] {
        didSet { spinner.paths = paths }
    }
    /** The image used to specify the look of the activity indicator. Only applies to the image mode. */
    public var image: UIImage? {
        didSet { spinner.image = UIImageView(image: image) }
    }
    
    /** Duration of the spinning animation. Applicable to both modes. */
    public var duration: Double = 1 {
        didSet { spinner.duration = duration }
    }
    
    /** The frame of the activity indicator will be a rectangle defined by this property. Only applies to the path mode.  */
    public var size: CGSize = CGSize(width: 60, height: 60) {
        didSet { spinner.size = size }
    }
    
    /**
     *  Initializer for the activity indicator.
     * - parameter view: The view the actvity indicator will be placed on.
     * - parameter mode: An enum to specify the appearance / behavior of the indicator.
     * Available modes include both path and image.
     */
    public init(on view: UIView, mode: SpinnerMode) {
        super.init(frame: view.frame)
        
        switch mode {
        case .path:
            spinner = PathSpinner()
        case .image:
            spinner = ImageSpinner()
        }
        spinner.setup(on: view)
    }
    
    /**
     * Not implemented
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     * Positions the activity indicator in the center of the view and starts animating.
     * Only one activity indicator can appear on the given view at any given time.
     */
    public func start() {
        if !startedSpinning {
            spinner.start()
            startedSpinning = true
        }
    }
    
    /**
     * Stops the activity indicator's animation and removes it from the view.
     */
    public func stop() {
        if startedSpinning {
            spinner.stop()
            startedSpinning = false
        }
    }
    
}
