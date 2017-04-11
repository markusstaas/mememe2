//
//  EditVC.swift
//  Meme Me 2.0
//
//  Created by Markus Staas on 3/31/17.
//  Copyright © 2017 Markus Staas. All rights reserved.
//

import UIKit

class EditVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createTextFields(textField: topTextField, defaultText: "TOP")
        createTextFields(textField: bottomTextField, defaultText: "BOTTOM")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        //subscribeToKeyboardNotifications()
        
    }
    
    func createTextFields(textField: UITextField, defaultText: String){
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = defaultText
        textField.textAlignment = .center
    }
    
    //MARK: Set text attributes
    let memeTextAttributes: [String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "Impact", size: 40)!,
        NSStrokeWidthAttributeName: -5.0
    ]
    
    
   
    
    
    
    
    
    /* To DO
     
     1. format textfields
     2. hide nav and toolbar while editing and rendering image
     3. render image
     4. hide cam button
     5. hide share button
     6. create meme model
     7. collection view
     8. table view
     9. tab based navigation
     10. 
     
     
    */




}

