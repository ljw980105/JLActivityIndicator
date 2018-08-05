//
//  PathSpinner.swift
//  JLActivityIndicator
//
//  Created by Jing Wei Li on 8/4/18.
//  Copyright © 2018 Jing Wei Li. All rights reserved.
//

import Foundation

class PathSpinner: ActivityIndicating {
    var image: UIImageView?
    var path: UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 60, height: 60))
    var shapeLayer: CAShapeLayer = CAShapeLayer()
    var strokeWidth: CGFloat = 3.0
    var duration: Double = 1
    var color: UIColor = UIColor.lightGray
    var size: CGFloat = 60
    var view: UIView?
    var startedSpinning = false
    
    // MARK: Protocol Stubs
    
    func setup(on view: UIView) {
        self.view = view
        shapeLayer.lineWidth = 3.0
        shapeLayer.fillColor = nil
        
    }
    
    func start() {
        guard !startedSpinning else { return }
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.frame = CGRect(x: 0, y: 0, width: size, height: size)
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = strokeWidth
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.shapeLayer.position = strongSelf.view?.center ?? CGPoint()
            strongSelf.shapeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            strongSelf.startedSpinning = true
            strongSelf.view?.layer.addSublayer(strongSelf.shapeLayer)
            strongSelf.startAnimation()
        }
        
    }
    
    func stop() {
        guard startedSpinning else { return }
        removeAnimation()
        startedSpinning = false
        for layer in self.view?.layer.sublayers ?? [] {
            if let shape = layer as? CAShapeLayer {
                shape.removeFromSuperlayer()
                break
            }
        }
    }
    
    func startAnimation() {
        let startAnimation = CABasicAnimation(keyPath: "strokeEnd")
        startAnimation.fromValue = 0.0
        startAnimation.toValue = 1.0
        startAnimation.duration = duration
        startAnimation.beginTime = 0
        
        shapeLayer.strokeStart = 0.0
        shapeLayer.strokeEnd = 1.0
        let reverseAnimation = CABasicAnimation(keyPath: "strokeStart")
        reverseAnimation.toValue = 1.0
        reverseAnimation.duration = duration
        reverseAnimation.beginTime = duration
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [reverseAnimation, startAnimation]
        animationGroup.repeatCount = .greatestFiniteMagnitude
        animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animationGroup.autoreverses = true
        animationGroup.duration = duration * 2
        
        shapeLayer.add(animationGroup, forKey: "spinningAnimation")
    }
    
    func removeAnimation() {
        if view?.layer.animation(forKey: "spinningAnimation") != nil {
            view?.layer.removeAnimation(forKey: "spinningAnimation")
        }
    }
    
    
}
