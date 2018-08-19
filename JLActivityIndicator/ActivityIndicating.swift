//
//  ActivityIndicating.swift
//  JLActivityIndicator
//
//  Created by Jing Wei Li on 8/4/18.
//  Copyright © 2018 Jing Wei Li. All rights reserved.
//

import Foundation
import UIKit

protocol ActivityIndicating {
    var image: UIImageView? { get set }
    var view: UIView? { get set }
    var paths: [UIBezierPath] { get set }
    var color: UIColor { get set }  
    var duration: Double { get set }
    var size: CGFloat { get set }
    var strokeWidth: CGFloat { get set }
    
    func setup(on view: UIView)
    func start()
    func stop()
    func startAnimation()
    func removeAnimation()
}
