//
//  SavedMemeVC.swift
//  Meme Me 2.0
//
//  Created by Markus Staas on 4/13/17.
//  Copyright © 2017 Markus Staas. All rights reserved.
//

import UIKit

class SavedMemeVC: UIViewController {
    
    var memeImage : UIImage?
    
    @IBOutlet weak var image: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = memeImage

        // Do any additional setup after loading the view.
    }



}
