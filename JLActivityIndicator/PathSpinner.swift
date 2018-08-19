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
    var paths: [UIBezierPath] = [UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 60, height: 60))]
    var shapeLayers: [CAShapeLayer] = []
    var strokeWidth: CGFloat = 3.0
    var duration: Double = 1
    var color: UIColor = UIColor.lightGray
    var size: CGFloat = 60
    var view: UIView?
    
    private var animationKeys = [String]()
    
    // MARK: Protocol Stubs
    
    func setup(on view: UIView) {
        self.view = view
    }
    
    func start() {
        for path in paths {
            let shapeLayer = CAShapeLayer()
            shapeLayers.append(shapeLayer)
            shapeLayer.lineWidth = 3.0
            shapeLayer.fillColor = nil
            shapeLayer.strokeColor = color.cgColor
            shapeLayer.frame = CGRect(x: 0, y: 0, width: size, height: size)
            shapeLayer.path = path.cgPath
            shapeLayer.lineWidth = strokeWidth
            
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                shapeLayer.position = strongSelf.view?.center ?? CGPoint()
                shapeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                strongSelf.view?.layer.addSublayer(shapeLayer)
            }
        }
        startAnimation()
    }
    
    func stop() {
        removeAnimation()
        for layer in self.view?.layer.sublayers ?? [] {
            if let shape = layer as? CAShapeLayer {
                shape.removeFromSuperlayer()
            }
        }
    }
    
    func startAnimation() {
        var count = 0
        animationKeys.removeAll()
        for shapeLayer in shapeLayers {
            let startAnimation = CABasicAnimation(keyPath: "strokeEnd")
            startAnimation.fromValue = 0.0
            startAnimation.toValue = 1.0
            startAnimation.duration = duration
            startAnimation.beginTime = 0
            
            let reverseAnimation = CABasicAnimation(keyPath: "strokeStart")
            reverseAnimation.fromValue = 0.0
            reverseAnimation.toValue = 1.0
            reverseAnimation.duration = duration
            reverseAnimation.beginTime = duration
            
            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [reverseAnimation, startAnimation]
            animationGroup.repeatCount = .greatestFiniteMagnitude
            animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animationGroup.autoreverses = true
            animationGroup.duration = duration * 2
            
            let animationKey = "spinningAnimation\(count)"
            shapeLayer.add(animationGroup, forKey: animationKey)
            animationKeys.append(animationKey)
            count += 1
        }
    }
    
    func removeAnimation() {
        for animationKey in animationKeys {
            if view?.layer.animation(forKey: animationKey) != nil {
                view?.layer.removeAnimation(forKey: animationKey)
            }
        }
    }
    
    
}
