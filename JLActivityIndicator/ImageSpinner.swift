//
//  ImageSpinner.swift
//  JLActivityIndicator
//
//  Created by Jing Wei Li on 8/4/18.
//  Copyright © 2018 Jing Wei Li. All rights reserved.
//

import Foundation

class ImageSpinner: ActivityIndicating {
    var paths: [JLBezierPath] = []
    var image: UIImageView?
    var duration: Double = 1
    var view: UIView?
    var reverseDirection: Bool = false
    var enableBackdrop: Bool = false
    var backdropView: UIView?
    
    private let rotationAnimationKey = "rotationanimationkey"
    
    func setup(on view: UIView) {
        self.view = view
    }
    
    func start() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self, let unwrappedImage = self?.image,
                let unwrappedView = self?.view else { return }
            if strongSelf.enableBackdrop {
                let maxImageLength = max(unwrappedImage.bounds.size.width, unwrappedImage.bounds.size.height)
                let backdropSize = maxImageLength + maxImageLength * 0.4
                strongSelf.backdropView = UIView(frame: CGRect(x: 0, y: 0, width: backdropSize, height: backdropSize))
                strongSelf.backdropView?.backgroundColor = JLConstants.backdropColor
                strongSelf.backdropView?.center =
                    CGPoint(x: unwrappedView.bounds.width/2, y: unwrappedView.bounds.height/2)
                strongSelf.backdropView?.layer.cornerRadius = backdropSize * 0.3
                strongSelf.backdropView?.clipsToBounds = true
                unwrappedImage.center = CGPoint(x: (strongSelf.backdropView?.bounds.width ?? 60)/2,
                                                y: (strongSelf.backdropView?.bounds.height ?? 60)/2)
                strongSelf.backdropView?.addSubview(unwrappedImage)
                unwrappedView.addSubview(strongSelf.backdropView!)
            } else {
                unwrappedImage.center = CGPoint(x: unwrappedView.bounds.width/2, y: unwrappedView.bounds.height/2)
                unwrappedView.addSubview(unwrappedImage)
            }
            
            if let animatedView = strongSelf.view?.subviews.last {
                animatedView.alpha = 0
                UIView.transition(with: animatedView,
                                  duration: JLConstants.fadeDuration,
                                  options: .curveEaseInOut,
                                  animations: { animatedView.alpha = 1},
                                  completion: nil)
            }
            strongSelf.startAnimation()
        }
    }
    
    func stop() {
        guard let spinningImage = self.image else { return }
        UIView.transition(with: spinningImage, duration: JLConstants.fadeDuration, options: [.transitionCrossDissolve],
        animations: { [weak self] in
            spinningImage.alpha = 0
            self?.backdropView?.alpha = 0
        }, completion: { [weak self] _ in
            self?.removeAnimation()
            spinningImage.removeFromSuperview()
            self?.backdropView?.removeFromSuperview()
        })
    }
    
    func startAnimation() {
        if image?.layer.animation(forKey: rotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = reverseDirection ? Float.pi * -2.0 : Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = .greatestFiniteMagnitude
            
            image?.layer.add(rotationAnimation, forKey: rotationAnimationKey)
        }
    }
    
    func removeAnimation() {
        if image?.layer.animation(forKey: rotationAnimationKey) != nil {
            image?.layer.removeAnimation(forKey: rotationAnimationKey)
        }
    }
    
    
}
