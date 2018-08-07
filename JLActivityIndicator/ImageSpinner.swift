//
//  ImageSpinner.swift
//  JLActivityIndicator
//
//  Created by Jing Wei Li on 8/4/18.
//  Copyright © 2018 Jing Wei Li. All rights reserved.
//

import Foundation

class ImageSpinner: ActivityIndicating {
    var path: UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 60, height: 60))
    var image: UIImageView?
    var duration: Double = 1
    var color: UIColor = UIColor.lightGray
    var size: CGFloat = 60
    var strokeWidth: CGFloat = 3.0
    var view: UIView?
    
    private let rotationAnimationKey = "rotationanimationkey"
    
    
    func setup(on view: UIView) {
        self.view = view
    }
    
    func start() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self, let unwrappedImage = self?.image,
                let unwrappedView = self?.view else { return }
            unwrappedImage.center = CGPoint(x: unwrappedView.bounds.width/2, y: unwrappedView.bounds.height/2)
            unwrappedView.addSubview(unwrappedImage)
            unwrappedView.bringSubview(toFront: unwrappedImage)
            strongSelf.startAnimation()
        }
    }
    
    func stop() {
        guard let spinningImage = self.image else { return }
        UIView.transition(with: spinningImage, duration: 0.1, options: [.transitionCrossDissolve],
        animations: {
            spinningImage.alpha = 0
        }, completion: { [weak self] _ in
            self?.removeAnimation()
            spinningImage.removeFromSuperview()
        })
    }
    
    func startAnimation() {
        if image?.layer.animation(forKey: rotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
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
