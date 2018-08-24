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
    var paths: [JLBezierPath] = [JLBezierPath()]
    var shapeLayers: [CAShapeLayer] = []
    var duration: Double = 1
    var size: CGSize = CGSize(width: 60, height: 60)
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
            shapeLayer.fillColor = nil
            shapeLayer.strokeColor = path.strokeColor.cgColor
            shapeLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            shapeLayer.path = path.strokePath.cgPath
            shapeLayer.lineWidth = path.strokeWidth
            
            shapeLayer.position = view?.center ?? CGPoint()
            shapeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            view?.layer.addSublayer(shapeLayer)
        }
        startAnimation()
    }
    
    func stop() {
        removeAnimation()
        shapeLayers.forEach { $0.removeFromSuperlayer() }
        shapeLayers.removeAll()
        animationKeys.removeAll()
    }
    
    func startAnimation() {
        var count = 0
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
