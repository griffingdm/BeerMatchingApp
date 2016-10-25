//
//  PatternTransition.swift
//  BeerMatchApp
//
//  Created by Mullins, Griffin on 10/23/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class PatternTransition: BaseTransition {
    var patternImage: UIImageView!
    var snap: UIView!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        //let fromController = fromViewController as! FirstViewController
        let toController = toViewController as! SecondViewController
        
        patternImage = UIImageView()
        patternImage.image = toController.patternImage.image
        patternImage.frame = toController.patternImage.frame
        patternImage.contentMode = toController.patternImage.contentMode
        patternImage.alpha = toController.patternImage.alpha
        
        toController.patternImage.alpha = 0
        toController.goButton.alpha = 0
        snap = toController.view.snapshotView(afterScreenUpdates: true)
        toController.view.alpha = 0
        
        containerView.addSubview(snap)
        snap.frame.origin.y = snap.frame.height
        
        UIView.animate(withDuration: duration, animations: {
            self.snap.frame.origin.y = 0
        }) { (finished: Bool) -> Void in
            toController.patternImage.alpha = 0.5
            toController.goButton.alpha = 1
            toController.view.alpha = 1
            self.snap.removeFromSuperview()
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        UIView.animate(withDuration: duration, animations: {
            fromViewController.view.frame.origin.y = fromViewController.view.frame.height
        }) { (finished: Bool) -> Void in
            self.finish()
        }
    }
}
