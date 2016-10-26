//
//  LaunchTransition.swift
//  BeerMatchApp
//
//  Created by Connolly, Trevor on 10/25/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class LaunchTransition: BaseTransition {
    var newLogo: UIImageView!
    
    //spring animation settings
    let springDamp: CGFloat! = 0.8
    let springVel: CGFloat! = 10
    
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        let fromController = fromViewController as! LaunchViewController
        let toController = toViewController as! FirstViewController
        toController.view.layoutIfNeeded()
        let fromImage = fromController.logoImage!
        let toImage = toController.logoImage!
        
        newLogo = UIImageView()
        newLogo.frame = containerView.convert(fromImage.frame, from: fromImage.superview)
        newLogo.image = fromImage.image
        newLogo.contentMode = fromImage.contentMode
        
        containerView.addSubview(newLogo)
        fromController.logoImage.isHidden = true
        toController.logoImage.isHidden = true
        toViewController.view.alpha = 0
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: springDamp, initialSpringVelocity: springVel, options: [], animations: {
            self.newLogo.frame = containerView.convert(toImage.frame, from: toImage.superview)
            }) { (Bool) in
        }
        
        UIView.animate(withDuration: duration/2, delay: duration/2, options: [], animations: {
            toViewController.view.alpha = 1
            }) { (Bool) in
                toController.logoImage.isHidden = false
                self.newLogo.removeFromSuperview()
                self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        fromViewController.view.alpha = 1
        UIView.animate(withDuration: duration, animations: {
            fromViewController.view.alpha = 0
        }) { (finished: Bool) -> Void in
            self.finish()
        }
    }
}
