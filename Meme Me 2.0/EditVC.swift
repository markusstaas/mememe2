//
//  EditVC.swift
//  Meme Me 2.0
//
//  Created by Markus Staas on 3/31/17.
//  Copyright © 2017 Markus Staas. All rights reserved.
//

import UIKit

class EditVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    var memedImage: UIImage!
    
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
        subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    
    //MARK: Choose image
    
    @IBAction func pickAnImage(_ sender: Any) {
        presentImagePicker(chosenSource: .photoLibrary)
    }
    
    @IBAction func shootAnImage(_ sender: Any) {
        presentImagePicker(chosenSource: .camera)
    }
    
    func presentImagePicker(chosenSource: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = chosenSource
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pickedImage.image = image
        }
        dismiss(animated: true, completion: nil)
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
    
    //MARK: Text editing
    func textFieldDidBeginEditing(_ textField: UITextField){
        if textField.tag == 1{
            if topTextField.text == "TOP"{
                topTextField.text = ""
            }
        }
        if textField.tag == 2{
            if bottomTextField.text == "BOTTOM"{
                bottomTextField.text = ""
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1{
            topTextField.resignFirstResponder()
        }
        if textField.tag == 2{
            bottomTextField.resignFirstResponder()
        }
        
        return true
        
    }
    
    
    //MARK: Move view if keyboard appears
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder{
            self.view.frame.origin.y =  getKeyboardHeight(notification) * -1
            pickedImage.contentMode = .scaleAspectFit
        }
    }
    
    func keyboardWillHide(){
        view.frame.origin.y = 0
        pickedImage.contentMode = .scaleAspectFit
    }
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func save() {
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: pickedImage.image, memedImage: memedImage)
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    func generateMemedImage() -> UIImage {
        toolBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.navigationController?.isNavigationBarHidden = false
        toolBar.isHidden = false
        
        return memedImage
    }
    
    //MARK: Share MEME
    @IBAction func shareButton(_ sender: Any) {
        
        self.memedImage = generateMemedImage()
        let shareMeme = UIActivityViewController(activityItems: [self.memedImage], applicationActivities: nil)
        
        // Save image to shared
        shareMeme.completionWithItemsHandler = {
            activity, completed, items, error in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        self.present(shareMeme, animated: true, completion: nil)
    }
 
}

