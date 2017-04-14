//
//  MemeCollectionVC.swift
//  Meme Me 2.0
//
//  Created by Markus Staas on 4/13/17.
//  Copyright © 2017 Markus Staas. All rights reserved.
//

import UIKit

class MemeCollectionVC: UIViewController, UICollectionViewDelegate
{

    @IBOutlet weak var memeCollView: UICollectionView!
    var memes : [Meme]!
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        self.memeCollView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCollViewCell", for: <#T##IndexPath#>) as! memeCollView
    
    }
    
    
/* override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VillainCollectionViewCell", for: indexPath) as! VillainCollectionViewCell
 let villain = self.allVillains[(indexPath as NSIndexPath).row]
 
 // Set the name and image
 cell.nameLabel.text = villain.name
 cell.villainImageView?.image = UIImage(named: villain.imageName)
 //cell.schemeLabel.text = "Scheme: \(villain.evilScheme)"
 
 return cell
 }*/
}
