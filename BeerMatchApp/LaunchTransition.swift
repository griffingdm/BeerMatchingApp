//
//  LaunchTransition.swift
//  BeerMatchApp
//
//  Created by Connolly, Trevor on 10/25/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class LaunchTransition: BaseTransition {
    
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
//        let fromView = fromViewController as! LaunchViewController
//        let toView = toViewController.childViewControllers[0] as! FirstViewController
//        
//        let newLogo: UIImageView! = UIImageView()
//        let imageFrame = containerView.convert(fromView.logoImage.frame, from: fromView.logoImage.superview)
//        let toImageFrame = containerView.convert(toView.logoImage.frame, to: fromView.logoImage.superview)
//        
//        newLogo.frame = imageFrame
//        newLogo.image = fromView.logoImage.image
//        newLogo.contentMode = fromView.logoImage.contentMode
//        
//        containerView.addSubview(newLogo)
//        
//        fromView.logoImage.alpha = 0
//        toView.logoImage.alpha = 0
        toViewController.view.alpha = 0
        
        UIView.animate(withDuration: duration, animations: {
//            newLogo.frame = toImageFrame
//            newLogo.contentMode = toView.logoImage.contentMode
            toViewController.view.alpha = 1
        }) { (finished: Bool) -> Void in
//            toView.logoImage.alpha = 1
//            newLogo.removeFromSuperview()
            
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
