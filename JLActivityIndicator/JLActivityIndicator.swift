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
    
    public var path: UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 60, height: 60)) {
        didSet { spinner.path = path }
    }
    public var image: UIImage? {
        didSet { spinner.image = UIImageView(image: image) }
    }
    public var duration: Double = 1 {
        didSet { spinner.duration = duration }
    }
    public var color: UIColor = UIColor.lightGray {
        didSet { spinner.color = color }
    }
    public var size: CGFloat = 60 {
        didSet { spinner.size = size }
    }
    public var strokeWidth: CGFloat = 3 {
        didSet { spinner.strokeWidth = strokeWidth }
    }
    
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
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func start() {
        spinner.start()
    }
    
    public func stop() {
        spinner.stop()
    }
    
}
