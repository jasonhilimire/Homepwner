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
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let item = itemStore.allItems[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    
    
}
