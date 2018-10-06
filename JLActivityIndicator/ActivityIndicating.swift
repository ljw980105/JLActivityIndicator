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
    var paths: [JLBezierPath] { get set }
    var duration: Double { get set }
    var reverseDirection: Bool { get set }
    var enableBackdrop: Bool { get set }
    
    func setup(on view: UIView)
    func start()
    func stop()
    func startAnimation()
    func removeAnimation()
}
