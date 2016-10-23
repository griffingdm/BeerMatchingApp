//
//  FirstViewController.swift
//  BeerMatchApp
//
//  Created by Mullins, Griffin on 10/18/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var patternImage: UIImageView!
    @IBOutlet weak var getStartedButton: RoundedButton!
    @IBOutlet weak var parentTileView: UIStackView!
    
    var patternTransition: PatternTransition!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getStartedButton.layer.cornerRadius = 6
        getStartedButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destinationViewController = segue.destination
        
        // Set the modal presentation style of your destinationViewController to be custom.
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.custom
        
        // Create a new instance of your fadeTransition.
        patternTransition = PatternTransition()
        
        // Tell the destinationViewController's  transitioning delegate to look in fadeTransition for transition instructions.
        destinationViewController.transitioningDelegate = patternTransition
        
        // Adjust the transition duration. (seconds)
        patternTransition.duration = 0.5
    }
     */

}
