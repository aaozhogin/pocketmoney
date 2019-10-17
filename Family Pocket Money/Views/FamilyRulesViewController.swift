//
//  FamilyRulesViewController.swift
//  Family Pocket Money
//
//  Created by Aleksandr Ozhogin on 16/10/19.
//  Copyright © 2019 Aleksandr Ozhogin. All rights reserved.
//

import UIKit
import CoreData

class FamilyRulesViewController: UITableViewController {

    var rulesArray = [FamilyRule]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
 
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        var costField = UITextField()
        
        let alert = UIAlertController(title: "Add new rule", message: "", preferredStyle: .alert )
        
        let action = UIAlertAction(title: "Add Rule", style: .default) { (action) in
            
            let newRule = FamilyRule(context: self.context)
            newRule.title = textField.text!
            
            self.rulesArray.append(newRule)
            
            self.saveRules()
            self.tableView.reloadData()
        }
        alert.addTextField{ (alertTextField) in
        
            alertTextField.placeholder = "Create new rule"
            textField = alertTextField
        
        }
    
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadRules()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rulesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ruleCell", for: indexPath)

        let rule = rulesArray[indexPath.row]
        cell.textLabel?.text = rule.title
        
        return cell
    }
   
           func saveRules() {
        
               do {
                   
                   try context.save()
                   
               } catch {
                   print("Error saving context: \(error)")
               }
           }

    func loadRules(with request : NSFetchRequest<FamilyRule> = FamilyRule.fetchRequest()) {

              do {
                   rulesArray = try context.fetch(request)
                   tableView.reloadData()
               } catch {
                   print("Error fetching data from context \(error)")
               }
                           
                 
                 
                
        }

}
