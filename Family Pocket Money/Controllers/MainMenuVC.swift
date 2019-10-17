//
//  MainMenuVC.swift
//  Family Pocket Money
//
//  Created by Aleksandr Ozhogin on 16/10/19.
//  Copyright © 2019 Aleksandr Ozhogin. All rights reserved.
//

import UIKit
import Firebase


class MainMenuVC: UIViewController {

    let db = Firestore.firestore()
    let useremail = Auth.auth().currentUser?.email
    var userName : String = ""
    var type : String = ""
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var typelabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          let userRef = db.collection("users").document(useremail!)
                userRef.getDocument { (doc, error) in
                    
                if let doc = doc, doc.exists {
                    let data = doc.data()
                    let username = data!["username"]!
                    
                    print(data!["isOrganizer"]!)
                    print(data!["isAdult"]!)
                    if String(describing: data!["isOrganizer"]) == "Optional(1)" {
                        self.type = "organizer"
                        print("This dick is an organizer")
                    } else if String(describing: data!["isAdult"]) == "Opional(1)" {
                        self.type = "adult"
                        print("This dick is not an organizer but an Adult")
                    } else {
                        self.type = "child"
                        print("This is a fucking kid")
                    }

                    
                        
                        
                    let result : String = String(describing: username)
                    self.usernameLabel.text = result
                    self.typelabel.text = self.type
        //
                } else {
                    self.usernameLabel.text = ""
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
