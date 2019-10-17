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
    
    let db = Firestore.firestore()
    
    var email : String?
    var password : String?
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var familynameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func signupButtonPressed(_ sender: Any) {
        if emailTextField.text == "" || passwordTextField.text == "" || usernameTextField.text == "" || familynameTextField.text == "" {
            
            ProgressHUD.showError("Please populate all fields")
            
        } else if familynameTextField.text != "" {
            let db = Firestore.firestore()
            
            guard let familyname = familynameTextField.text else { return }

                let docRef = db.collection("families").document(familyname)

                docRef.getDocument { (document, error) in
                    if let document = document {
                        if document.exists{
                            ProgressHUD.showError("This family name is already taken. Please choose another one or ask organizer to add you.")
                        } else {
                        SVProgressHUD.show()
                        Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                            if error != nil {
                        ProgressHUD.showError("Something went wrong. Try again")
                        SVProgressHUD.dismiss()
                            } else {
                                print("user created successfully")
                            self.db.collection("users").document(self.emailTextField.text!).setData([
                                "username": self.usernameTextField.text!,
                                "familyname" : self.familynameTextField.text!,
                                "isAdult": true,
                                "isOrganizer": true
                                
                ]) {(error:Error?) in
                    if let error = error {
                        print("\(error.localizedDescription)")
                    } else {
                        print("'userfiles' was successfully created and saved.")
                        }
                    }
            self.db.collection("families").document(self.familynameTextField.text!).setData([
                            "email": self.emailTextField.text!,
                            "isOrganizer" : true
                            
                    ]) {(error:Error?) in
                        if let error = error {
                            print("\(error.localizedDescription)")
                        } else {
                            print("'families' was successfully created and saved.")
                        }
                            
                        }
                    SVProgressHUD.dismiss()
                    
                    self.performSegue(withIdentifier: "toMainMenu", sender: self)
                }
            }
        }
    }
    }
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let emailValue = email {
            emailTextField.text = emailValue
        }
        
        if let passwordValue = password{
            passwordTextField.text = passwordValue
        }
        
        
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

