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
    var view: UIView?
    var reverseDirection: Bool = false
    var animatedView: UIView?
    var enableBackdrop: Bool = false
    
    private var animationKeys = [String]()
    
    private lazy var size: CGSize = {
        var maxWidth: CGFloat = 0, maxHeight: CGFloat = 0
        for path in paths {
            if maxWidth < path.strokePath.bounds.width { maxWidth =  path.strokePath.bounds.width }
            if maxHeight < path.strokePath.bounds.height { maxHeight = path.strokePath.bounds.height }
        }
        return CGSize(width: maxWidth, height: maxHeight)
    }()
    
    private lazy var backgroundSize: CGSize = {
        return CGSize(width: size.width * 1.4, height: size.height * 1.4)
    }()
    
    // MARK: Protocol Stubs
    
    func setup(on view: UIView) {
        self.view = view
    }
    
    func start() {
        animatedView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: backgroundSize))
        
        if enableBackdrop {
            animatedView?.backgroundColor = JLConstants.backdropColor
            animatedView?.layer.cornerRadius =
                max(animatedView?.bounds.width ?? 0, animatedView?.bounds.height ?? 0) * 0.3
            animatedView?.clipsToBounds = true
            animatedView?.alpha = 0.5
        }
        
        view?.addSubview(animatedView ?? UIView())
        animatedView?.center = view?.center ?? CGPoint()
        JLUtilities.center(subview: animatedView, on: view)
        
        for path in paths {
            let shapeLayer = CAShapeLayer()
            shapeLayers.append(shapeLayer)
            shapeLayer.fillColor = nil
            shapeLayer.strokeColor = path.strokeColor.cgColor
            shapeLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            shapeLayer.path = path.strokePath.cgPath
            shapeLayer.lineWidth = path.strokeWidth
            shapeLayer.position =  CGPoint(x: backgroundSize.width/2 , y: backgroundSize.height/2)
            animatedView?.layer.addSublayer(shapeLayer)
        }
        
        if let animatedView = animatedView {
            animatedView.alpha = 0
            UIView.transition(with: animatedView,
                              duration: JLConstants.fadeDuration,
                              options: [.transitionCrossDissolve, .curveEaseInOut],
                              animations: { animatedView.alpha = 1 },
                              completion: nil)
        }
        
        startAnimation()
    }
    
    func stop() {
        removeAnimation()
        shapeLayers.forEach { $0.removeFromSuperlayer() }
        shapeLayers.removeAll()
        animationKeys.removeAll()
        if let animatedView = animatedView {
            UIView.transition(with: animatedView,
                              duration: JLConstants.fadeDuration,
                              options: .curveEaseInOut,
                              animations: { animatedView.alpha = 0 },
                              completion: { _ in animatedView.removeFromSuperview() } )
        }
    }
    
    func startAnimation() {
        var count = 0
        let fromValue = reverseDirection ? 1.0 : 0.0
        let toValue = reverseDirection ? 0.0 : 1.0
        
        for shapeLayer in shapeLayers {
            let startAnimation = CABasicAnimation(keyPath: "strokeEnd")
            startAnimation.fromValue = fromValue
            startAnimation.toValue = toValue
            startAnimation.duration = duration
            startAnimation.beginTime = 0
            
            let reverseAnimation = CABasicAnimation(keyPath: "strokeStart")
            reverseAnimation.fromValue = fromValue
            reverseAnimation.toValue = toValue
            reverseAnimation.duration = duration
            reverseAnimation.beginTime = duration
            
            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [reverseAnimation, startAnimation]
            animationGroup.repeatCount = .greatestFiniteMagnitude
            animationGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
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
            if animatedView?.layer.animation(forKey: animationKey) != nil {
                animatedView?.layer.removeAnimation(forKey: animationKey)
            }
        }
    }
    
}
