//
//  LoginViewController.swift
//  Sample
//
//  Created by SysBig on 26/10/17.
//  Copyright © 2017 SysBig. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var effectView: UIVisualEffectView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var effect : UIVisualEffect!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        effect = effectView.effect
        effectView.effect = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton)
    {
        if let email = emailTextField.text, let password = passwordTextField.text
        {
            
            Auth.auth().signIn(withEmail:email , password: password, completion: { (user, error) in
                
                if error != nil
                {
                    return
                }
                
                print("login success")
                self.animateInView()
//                guard let userid = user?.uid else
//                {
//                    return
//                }
//
//                BackendProvider.sharedInstance.saveUserData(userId: userid,email: email, password: password)
                //BackendProvider.sharedInstance.saveUserProfileData()
            })        
        }
    }

    @IBAction func createAccountButtonAction(_ sender: UIButton)
    {
        BackendProvider.sharedInstance.retrieveData { (responseDict) in
            
            if let userPic = responseDict["userPhoto"] as? String
            {
              guard  let imageData = Data(base64Encoded: userPic, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
                else
               {
                return
                }
                let image = UIImage(data: imageData)
                DispatchQueue.main.async
                {
                    self.profileImage.image = image
                }
            }
        }
    }
    
    @IBAction func updateButtonAction(_ sender: UIButton)
    {
        //BackendProvider.sharedInstance.updateUserData()
    }
    @IBAction func removeButtonAction(_ sender: UIButton)
    {
        BackendProvider.sharedInstance.deleteUserData()
    }
    
    
    func animateInView()
    {
        self.view.addSubview(popUpView)
        self.popUpView.center = self.view.center
        self.popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.popUpView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.effectView.effect  = self.effect
            self.popUpView.alpha = 1.0
            self.popUpView.transform = CGAffineTransform.identity
        }
        
    }
    func animateOutView()
    {
        UIView.animate(withDuration: 0.3, animations:
        {
            self.effectView.effect  = nil
            self.popUpView.alpha = 0
            self.popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)

        }) { (success) in
            self.popUpView.removeFromSuperview()
            
            let imagesArray = [#imageLiteral(resourceName: "heart1"),#imageLiteral(resourceName: "heart2"),#imageLiteral(resourceName: "heart3"),#imageLiteral(resourceName: "heart4")]
            
            self.profileImage.animationImages = imagesArray
            self.profileImage.animationDuration = 1.0
            self.profileImage.startAnimating()
            
            let animateVC = self.storyboard?.instantiateViewController(withIdentifier:"AnimateViewController") as! AnimateViewController
            self.present(animateVC, animated: true, completion: nil)
        }
    }
    @IBAction func doneButton(_ sender: UIButton)
    {
        animateOutView()
    }
}
