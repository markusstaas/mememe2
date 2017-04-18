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
    @IBOutlet weak var getStartedButt: UIButton!
    
    
    var memes : [Meme]!
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        self.memeTable.reloadData()
        if memes.isEmpty{
            
            getStartedButt.isHidden = true
            
        }else{
            getStartedButt.isHidden = false
        }
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
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            //change current state of memes to avoid crash/row error
            self.memes.remove(at: indexPath.row)
            //update table
            tableView.deleteRows(at: [indexPath], with: .automatic)
            //remove data from model
           (UIApplication.shared.delegate as! AppDelegate).memes.remove(at: indexPath.row)
        }
    }



}
