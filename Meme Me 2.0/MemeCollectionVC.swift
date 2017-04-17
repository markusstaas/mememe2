//
//  MemeCollectionVC.swift
//  Meme Me 2.0
//
//  Created by Markus Staas on 4/13/17.
//  Copyright © 2017 Markus Staas. All rights reserved.
//

import UIKit

class MemeCollectionVC: UICollectionViewController
{

   
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet var memeCollView: UICollectionView!
    var memes : [Meme]!
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        self.memeCollView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space )) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }

     override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCollViewCell", for: indexPath) as! MemeCollectionViewCell
      let memeColl = self.memes[(indexPath as NSIndexPath).row]
        cell.memeCollImage.image = memeColl.memedImage
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        

        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SavedMemeVC") as! SavedMemeVC
        
        let meme = memes[(indexPath as NSIndexPath).row]
        detailController.memeImage = meme.memedImage
        

        navigationController!.pushViewController(detailController, animated: true)
        
        
    }
}
