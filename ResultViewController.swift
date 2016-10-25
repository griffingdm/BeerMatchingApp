//
//  ResultViewController.swift
//  BeerMatchApp
//
//  Created by Mullins, Griffin on 10/22/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var patternImage: UIImageView!
    @IBOutlet weak var parentTileView: UIStackView!
    @IBOutlet weak var ResultImage: UIImageView!
    
    @IBOutlet weak var h1Label: UILabel!
    @IBOutlet weak var h2Label: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var result: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        doneButton.layer.cornerRadius = 6
        doneButton.layer.masksToBounds = true
        setUpResult()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressDone(_ sender: AnyObject) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: {})
        //navigationController?.popViewController(animated: true)
    }
    
    func setUpResult(){
        if result {
            ResultImage.image = #imageLiteral(resourceName: "Success")
            view.backgroundColor = #colorLiteral(red: 0.6352941176, green: 0.7215686275, blue: 0.6823529412, alpha: 1)
            h1Label.text = "WOW! YOU REALLY KNOW YOUR BREWS."
            h2Label.text = "Your taste buds are on-point! You guessed each beer correctly. Please show this screen to the event-person in front of you to collect a raffle ticket and a chance to win a lot of cool stuff!"
        } else {
            ResultImage.image = #imageLiteral(resourceName: "Bummer")
            view.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.368627451, blue: 0.337254902, alpha: 1)
            h1Label.text = "BUMMER. YOUR TASTE BUDS FAILED YOU."
            h2Label.text = "You failed to match the beers correctly, better luck next time."
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
