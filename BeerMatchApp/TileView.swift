//
//  TileView.swift
//  BeerMatchApp
//
//  Created by Mullins, Griffin on 10/22/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class TileView: UIView {
    
    var theImage: UIImageView?
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    init(frame: CGRect, image: UIImageView){
        super.init(frame: frame)
        setImage(image: image)
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init?(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)
    }
    
    func setImage(image: UIImageView!){
        theImage = image
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
