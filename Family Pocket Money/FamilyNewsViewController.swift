//
//  FamilyNewsViewController.swift
//  
//
//  Created by Aleksandr Ozhogin on 5/9/19.
//

import UIKit
import Firebase
import ChameleonFramework
import ProgressHUD


class FamilyNewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    @IBAction func mainMenuButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var messageArray : [Message] = [Message]()
    
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = Database.database().reference().child("Messages")
        let messageDictionary = ["Sender" : Auth.auth().currentUser?.email, "MessageBody" : messageTextField.text!]
        messagesDB.childByAutoId().setValue(messageDictionary) {
            (error, reference) in
            if error != nil {
                print(error!)
                ProgressHUD.showError("Sending failed")
                self.sendButton.isEnabled = true
                self.messageTextField.isEnabled = true
            } else {
                self.messageTextField.text = ""
                self.sendButton.isEnabled = true
                self.messageTextField.isEnabled = true
                
                
            }
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        cell.textMessageLabel.text = messageArray[indexPath.row].messageBody
        cell.userMessageLabel.text = messageArray[indexPath.row].sender
        
        return cell
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        messageTextField.delegate = self
        
        messageTableView.register(UINib(nibName: "customMessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        configureTableView()
        retrieveMessages()
        
        messageTableView.separatorStyle = .none
        // Do any additional setup after loading the view.
        
    }
    
    func configureTableView() {
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    func retrieveMessages() {
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) {(snapshot) in
            let snapshotVlaue = snapshot.value as! Dictionary<String , String>
            let text = snapshotVlaue["MessageBody"]!
            let sender = snapshotVlaue["Sender"]!
            
            let newMessage = Message()
            newMessage.messageBody = text
            newMessage.sender = sender
            
            self.messageArray.append(newMessage)
            self.configureTableView()
            self.messageTableView.reloadData()
        }
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


