//
//  RegisterViewController.swift
//  
//
//  Created by Aleksandr Ozhogin on 5/9/19.
//

import UIKit
import ProgressHUD
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewUserScreen" {
            let destinationVC = segue.destination as! NewUserViewController
            
            if emailTextField.text != "" {destinationVC.email = emailTextField.text}
            if passwordTextField.text != "" {
            destinationVC.password = passwordTextField.text}
            
        }
    }
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func newuserButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
            if emailTextField.text == "" || passwordTextField.text == "" {
                
                ProgressHUD.showError("Please enter Email/Password")
        
                } else {
                    SVProgressHUD.show()
                    Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                    if error != nil {
                        SVProgressHUD.dismiss()
                        ProgressHUD.showError(("Something went wrong, try again"))
                        
                    } else {
                        print("Login was successful")
                        
                        UserDefaults.standard.set(self.emailTextField.text, forKey: "email")
                        UserDefaults.standard.set(self.passwordTextField.text, forKey: "password")
                        
                        SVProgressHUD.dismiss()
                        
                        self.performSegue(withIdentifier: "toMainMenu", sender: self)
                }
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        if let email = UserDefaults.standard.object(forKey: "email") as? String, let password = UserDefaults.standard.object(forKey: "password") as? String {
                SVProgressHUD.show()
            Auth.auth().signIn(withEmail: email, password: password) {(user, error) in
                if error != nil {
                    SVProgressHUD.dismiss()
                    ProgressHUD.showError("Failed to login automatically")
                    
                }  else {
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "toMainMenu", sender: self)
                }
                
            }
            
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
