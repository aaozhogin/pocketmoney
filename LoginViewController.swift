//
//  LoginViewController.swift
//  Family Pocket Money
//
//  Created by Aleksandr Ozhogin on 5/9/19.
//  Copyright © 2019 Aleksandr Ozhogin. All rights reserved.
//

import UIKit
import ProgressHUD

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonPressed(_ sender: Any) {
//        if usernameTextField.text == nil || passwordTextField.text == nil {
//            ProgressHUD.showError("")
//
//
//        } else {
//
//            print("ok")
//        }
//
        
    }
    
    @IBAction func newUserButtonPressed(_ sender: Any) {
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
