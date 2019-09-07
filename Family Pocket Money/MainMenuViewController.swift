//
//  MainMenuViewController.swift
//  
//
//  Created by Aleksandr Ozhogin on 5/9/19.
//

import UIKit
import Firebase
import SVProgressHUD
import ProgressHUD

class MainMenuViewController: UIViewController {

    
    @IBAction func logoffButtonPressed(_ sender: Any) {
        
        do {
            SVProgressHUD.show()
            
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            SVProgressHUD.dismiss()
            
            dismiss(animated: true, completion: nil)
            
        } catch {
            ProgressHUD.showError("Something went wrong")
            SVProgressHUD.dismiss()
        }
        
    }
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = Auth.auth().currentUser?.email as String?

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
