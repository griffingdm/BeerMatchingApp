//
//  SecondViewController.swift
//  BeerMatchApp
//
//  Created by Mullins, Griffin on 10/18/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var mamaView: UIView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var parentTileView: UIView!
    @IBOutlet weak var patternImage: UIImageView!
    
    @IBOutlet weak var beerOneView: TileView!
    @IBOutlet weak var beerTwoView: TileView!
    @IBOutlet weak var beerThreeView: TileView!
    @IBOutlet weak var publicAleView: TileView!
    @IBOutlet weak var witbierView: TileView!
    @IBOutlet weak var mosaicIPAView: TileView!
    
    @IBOutlet weak var witbierImage: UIImageView!
    @IBOutlet weak var mosaicImage: UIImageView!
    @IBOutlet weak var publicAleImage: UIImageView!
    @IBOutlet weak var orangeBeerImage: UIImageView!
    @IBOutlet weak var yellowBeerImage: UIImageView!
    @IBOutlet weak var redBeerImage: UIImageView!
    
    
    var tiles: [TileView]! = []
    var images: [UIImageView]! = []
    var ogButtonOrigin: CGPoint = CGPoint()
    
    //spring animation settings
    let animateDuration: TimeInterval! = 0.25
    let springDamp: CGFloat! = 0.8
    let springVel: CGFloat! = 10
    let velRange: UInt32! = 5
    let minSpring: UInt32! = 5
    
    let tileColor: UIColor = #colorLiteral(red: 0.9593779445, green: 0.6258671284, blue: 0.2463788688, alpha: 1)
    let orangeBeerColor: UIColor = #colorLiteral(red: 0.912281692, green: 0.536565721, blue: 0.1552669704, alpha: 1)
    let yellowBeerColor: UIColor = #colorLiteral(red: 0.9712998271, green: 0.8346524835, blue: 0.1162054613, alpha: 1)
    let redBeerColor: UIColor = #colorLiteral(red: 0.6423732042, green: 0.2146595418, blue: 0.0006825692253, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tiles = [beerOneView, beerTwoView, beerThreeView, publicAleView, witbierView, mosaicIPAView]
        images = [orangeBeerImage, yellowBeerImage, redBeerImage, publicAleImage, witbierImage, mosaicImage]
        
        for (index, tile) in tiles.enumerated() {
            //add corner radius
            let cornerRadius: CGFloat = 100
            tile.layer.cornerRadius = cornerRadius
            tile.clipsToBounds = true
            
            tile.setImage(image: images[index])
            
            //add a pan gesture recognizer to everything
            let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
            tile.addGestureRecognizer(gestureRecognizer)
            
            tile.alpha = 0
        }
        
        //store button location, hide it
        ogButtonOrigin = goButton.center
        goButton.alpha = 1
        showButton(hide: true)
        
        //make button rounded
        goButton.layer.cornerRadius = 6
        goButton.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for tile in tiles {
            let ogTileFrame = tile.frame
            let velocity = CGFloat(arc4random_uniform(velRange) + minSpring)
            let duration: TimeInterval = 1
            tile.alpha = 1
            tile.frame.origin.y = view.frame.height
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: velocity, options: [], animations: {
                tile.frame = ogTileFrame
                }, completion: { (Bool) in
                    delay(0.1, closure: {
                    })
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: view)
        
        let theView = gestureRecognizer.view! as! TileView
        let theIntersects: [TileView?] = intersectingTile(tileView: theView)
        let moveTo: CGPoint = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
        //let fingerPoint: CGPoint = gestureRecognizer.location(ofTouch: 0, in: self.view)
        
        gestureRecognizer.setTranslation(CGPoint.zero, in: view)
        
        if gestureRecognizer.state == .began {
            print("\(theIntersects.count)")
            for theIntersect in theIntersects {
                if matchedWith(view: theView, viewTwo: theIntersect) {
                    animateTile(tileOne: theView, tileTwo: theIntersect, matching: false)
                }
            }
            
            //snapToFinger(view: theView, point: fingerPoint)
            fadeOthers(view: theView)
            showButton(hide: true)
            
        } else if gestureRecognizer.state == .changed {
            // note: 'view' is optional and need to be unwrapped
            theView.center = moveTo
            
        } else if gestureRecognizer.state == .ended {
            
            snapTile(tileView: theView)
            snapAll()
            
            UIView.animate(withDuration: animateDuration, animations: {
                for tile in self.tiles {
                    if self.numOfMatches(theView: tile) == 0 {
                        tile.alpha = 1
                    }
                }
            })
            
            switch numOfMatches() {
            case 3:
                finishAnimation()
            default:
                break
            }
        }
    }
    
    func snapToFinger(view: TileView, point: CGPoint){
        UIView.animate(withDuration: animateDuration, delay: 0, usingSpringWithDamping: springDamp, initialSpringVelocity: springVel, options: [], animations: {
            view.center = point
        }) { (Bool) in
        }
    }
    
    func finishAnimation() {
        let offset: CGFloat = 250
        
        UIView.animate(withDuration: animateDuration, delay: 0, usingSpringWithDamping: springDamp, initialSpringVelocity: springVel, options: [], animations: {
            for tile in self.tiles {
                if self.isBeer(tileView: tile){
                    let match: TileView! = self.getMatch(tile: tile)!
                    let newFrame = self.mamaView.convert(self.parentTileView.frame, from: tile.superview)
                    
                    tile.center.y = newFrame.height / 2
                    match.center.y = newFrame.height / 2
                    
                    switch tile.tag {
                    case 1:
                        tile.center.x = (newFrame.width / 2) - offset
                        match.center.x = (newFrame.width / 2) - offset
                    case 2:
                        tile.center.x = (newFrame.width / 2)
                        match.center.x = (newFrame.width / 2)
                    case 3:
                        tile.center.x = (newFrame.width / 2) + offset
                        match.center.x = (newFrame.width / 2) + offset
                    default:
                        break
                    }
                }
            }
            
            }, completion: { (Bool) in
                self.showButton(hide: false)
        })

    }
    
    func snapAll(){
        for tile in tiles{
            let intersections: [TileView?] = intersectingTile(tileView: tile)
            if intersections.count != 0 {
                for interTile in intersections{
                    if numOfMatches(theView: tile) == 0 && numOfMatches(theView: interTile!) == 0{
                        snapTile(tileView: tile)
                    }
                }
            }
        }
    }
    
    func getMatch(tile: TileView) -> TileView? {
        for thing in tiles {
            if tile.center == thing.center && tile.tag != thing.tag {
                return thing
                break
            }
        }
        return nil
    }
    
    //if it intersects, snap to it if something isnt already snapped
    func snapTile(tileView: TileView){
        let interTiles: [TileView?] = intersectingTile(tileView: tileView)
        if interTiles.count != 0 {
            let interTile: TileView? = interTiles[interTiles.count - 1]
            //for interTile in interTiles{
                if numOfMatches(theView: interTile!) < 1 {
                    animateTile(tileOne: tileView, tileTwo: interTile, matching: true)
                    UIView.animate(withDuration: animateDuration, delay: 0, usingSpringWithDamping: springDamp, initialSpringVelocity: springVel, options: [], animations: {
                        tileView.center = interTile!.center
                        if self.isBeer(tileView: tileView){
                            tileView.alpha = 0
                        } else {
                            interTile!.alpha = 0
                        }
                        }, completion: { (Bool) in
                    })
                }
            //}
        } else {
            print("no intersecting tile")
        }
    }
    
    func animateTile(tileOne: TileView?, tileTwo: TileView?, matching: Bool){
        if tileOne != nil && tileTwo != nil{
            var beerTile: TileView!
            var breweryTile: TileView!
            
            if isBeer(tileView: tileOne!){
                breweryTile = tileTwo
                beerTile = tileOne
            } else {
                breweryTile = tileOne
                beerTile = tileTwo
            }
            
            UIView.animate(withDuration: animateDuration, delay: 0, options: .curveEaseOut, animations: {
                if matching {
                    breweryTile.theImage?.alpha = 1
                    switch beerTile.tag{
                    case 1:
                        breweryTile.backgroundColor = self.redBeerColor
                    case 2:
                        breweryTile.backgroundColor = self.orangeBeerColor
                    case 3:
                        breweryTile.backgroundColor = self.yellowBeerColor
                    default:
                        breweryTile.backgroundColor = self.tileColor
                    }
                } else {
                    if self.numOfMatches(theView: tileOne!) < 2 {
                        beerTile.alpha = 1
                        breweryTile.theImage?.alpha = 0.5
                        breweryTile.backgroundColor = self.tileColor
                    }
                }
            }) { (Bool) in
            }
        }
    }
    
    //returns which view the other type of view intersects with
    func intersectingTile(tileView: TileView) -> [TileView?] {
        var intersections: [TileView?] = []
        
        
        for tile in tiles {
            if isBeer(tileView: tileView) && tile.tag != tileView.tag {
                if tileView.frame.intersects(tile.frame) {
                    if !isBeer(tileView: tile) {
                        intersections.append(tile)
                    }
                }
            } else if tile.tag != tileView.tag  {
                if tileView.frame.intersects(tile.frame){
                    if isBeer(tileView: tile) {
                        intersections.append(tile)
                    }
                }
            }
        }
        
        
        return intersections
    }
    
    func fadeOthers(view: TileView) {
        UIView.animate(withDuration: animateDuration) { 
            if self.isBeer(tileView: view) {
                for tile in self.tiles {
                    if self.isBeer(tileView: tile) && tile.tag != view.tag && self.numOfMatches(theView: tile) == 0{
                        tile.alpha = 0.2
                    }
                }
            } else {
                for tile in self.tiles {
                    if !self.isBeer(tileView: tile) && tile.tag != view.tag && self.numOfMatches(theView: tile) == 0 {
                        tile.alpha = 0.2
                    }
                }
            }
        }
    }
    
    func isBeer(tileView: TileView) -> Bool{
        switch tileView.tag {
        case 1...3:
            return true
        default:
            return false
        }
    }
    
    func matchedWith(view: TileView?, viewTwo: TileView?) -> Bool {
        if view?.center == viewTwo?.center {
            return true
        } else {
            return false
        }
    }
    
    //return total of matches
    func numOfMatches() -> Int {
        var matches = 0
        
        for tile in tiles {
            for compTile in tiles {
                if tile.tag != compTile.tag && compTile.center == tile.center {
                    matches += 1
                }
            }
        }
        matches = matches / 2
        print ("total matches: \(matches)")
        return matches
    }
    
    //return how many are matched with a view
    func numOfMatches(theView: UIView) -> Int {
        var matches = 0
        
        for tile in tiles {
            if tile.tag != theView.tag && theView.center == tile.center {
                matches += 1
            }
        }
        print ("this tile's matches: \(matches)")
        return matches
    }
    
    //return how many are matched with a view
    func numOfIntersections(theView: UIView) -> Int {
        var intersections = 0
        
        for tile in tiles {
            if tile.tag != theView.tag && theView.frame.intersects(tile.frame) {
                intersections += 1
            }
        }
        print ("this tile's matches: \(intersections)")
        return intersections
    }
    
    func showButton(hide: Bool){
        UIView.animate(withDuration: animateDuration, delay: 0, usingSpringWithDamping: springDamp, initialSpringVelocity: springVel, options: [], animations: {
            if hide && self.goButton.alpha == 1 {
                self.goButton.frame.origin.y = self.view.frame.height
                self.goButton.alpha = 0
            } else if !hide && self.goButton.alpha == 0 {
                self.goButton.alpha = 1
                self.goButton.center = self.ogButtonOrigin
            }
            }, completion: { (Bool) in
        })
        
    }
    
    @IBAction func tapGoButton(_ sender: AnyObject) {
        performSegue(withIdentifier: "resultSegue", sender: nil)
    }
    
    func correctlyMatched() -> Bool {
        if mosaicIPAView.center == beerOneView.center && witbierView.center == beerTwoView.center && publicAleView.center == beerThreeView.center {
            print("matched correctly!")
            return true
        } else {
            print("matched incorrectly")
            return false
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as! ResultViewController
        destination.result = correctlyMatched()
    }
    
}
