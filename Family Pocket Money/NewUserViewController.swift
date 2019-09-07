//
//  NewUserViewController.swift
//  Family Pocket Money
//
//  Created by Aleksandr Ozhogin on 5/9/19.
//  Copyright © 2019 Aleksandr Ozhogin. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import ProgressHUD


class NewUserViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    

    @IBAction func signupButtonPressed(_ sender: Any) {
        if emailTextField.text == "" || passwordTextField.text == "" {
            
            ProgressHUD.showError("Please enter Email/Password")
            
        } else {
            SVProgressHUD.show()
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error != nil {
                    ProgressHUD.showError("Something went wrong. Try again")
                    SVProgressHUD.dismiss()
                } else {
                    
                    
                    SVProgressHUD.dismiss()
                    
                    self.performSegue(withIdentifier: "toMainMenu", sender: self)
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
