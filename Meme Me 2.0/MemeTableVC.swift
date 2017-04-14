//
//  MemeTableVC.swift
//  Meme Me 2.0
//
//  Created by Markus Staas on 4/13/17.
//  Copyright © 2017 Markus Staas. All rights reserved.
//

import UIKit
import Foundation

class MemeTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var memeTable: UITableView!
    var memes : [Meme]!
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        self.memeTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeTable.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let memeListItem = memes[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = "\(memeListItem.topText!)"
        cell.detailTextLabel?.text = "\(memeListItem.bottomText!)"
        cell.imageView?.image = memeListItem.memedImage
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SavedMemeVC") as! SavedMemeVC
        let meme = memes[(indexPath as NSIndexPath).row]
        detailController.memeImage = meme.memedImage
        self.navigationController!.pushViewController(detailController, animated: true)
    }



}
