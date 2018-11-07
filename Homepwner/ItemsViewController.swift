//  ItemsViewController.swift
//  Homepwner
//
//  Created by Jason Hilimire on 10/21/18.
//  Copyright © 2018 Peanut Apps. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    
    @IBAction func addNewItem(_ sender: UIButton) {
        //Create a new item and add to the store
        let newItem = itemStore.createItem()
        
        
        //Insert this new row into the table
        
        //Figure out where that item is in the array
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
        
        //Inser tnew row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        // If currently editing
        if isEditing {
            //change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
            
            //Turn off Editing mode
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            
            //Enter Editing mode
            setEditing(true, animated: true)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get height of status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items where n = row this cell will appear on the tableview
    
        let item = itemStore.allItems[indexPath.row]
        
        // configure the cell with the Item
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        
        if item.valueInDollars >= 50 {
            cell.valueLabel.textColor = UIColor.green
        } else {
            cell.valueLabel.textColor = UIColor.red
        }
        cell.valueLabel.text = "$\(item.valueInDollars)"
        return cell
    }
    
    // Delete a row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            /// Add the Action Sheet
            let title = "Delete \(item.name)"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
            
            self.itemStore.removeItem(item)
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            
            ac.addAction(deleteAction)
            
            //Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
    
    //enable moving a row
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //Update the Model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }

    
}
