//
//  BubbleUpTransition.swift
//  BeerMatchApp
//
//  Created by Mullins, Griffin on 10/23/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class BubbleUpTransition: BaseTransition {
    
    //spring animation settings
    let animateDuration: TimeInterval! = 0.25
    let springDamp: CGFloat! = 0.8
    let springVel: CGFloat! = 10
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        toViewController.view.frame.origin.y = toViewController.view.frame.height
        
        UIView.animate(withDuration: animateDuration, delay: 0, usingSpringWithDamping: springDamp, initialSpringVelocity: springVel, options: [], animations: {
            toViewController.view.frame.origin.y = toViewController.view.frame.height / 2
        }) { (Bool) in
            UIView.animate(withDuration: self.animateDuration, delay: 0, usingSpringWithDamping: self.springDamp, initialSpringVelocity: self.springVel, options: [], animations: {
                toViewController.view.frame.origin.y = 0
                }, completion: { (Bool) in
            self.finish()
            })
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        UIView.animate(withDuration: animateDuration, delay: 0, usingSpringWithDamping: springDamp, initialSpringVelocity: springVel, options: [], animations: {
            fromViewController.view.frame.origin.y = fromViewController.view.frame.height / 2
        }) { (Bool) in
            UIView.animate(withDuration: self.animateDuration, delay: 0, usingSpringWithDamping: self.springDamp, initialSpringVelocity: self.springVel, options: [], animations: {
                fromViewController.view.frame.origin.y = fromViewController.view.frame.height
                }, completion: { (Bool) in
                    self.finish()
            })
        }
    }
}
