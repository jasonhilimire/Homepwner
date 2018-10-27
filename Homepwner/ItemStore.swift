//
//  ItemStore.swift
//  Homepwner
//
//  Created by Jason Hilimire on 10/22/18.
//  Copyright © 2018 Peanut Apps. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    @IBAction func addNewItem(_ sender: UIButton) {
        
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        
    }
    
    @discardableResult func createItem() -> Item {
    let newItem = Item(random: true)
    
    allItems.append(newItem)
    
    return newItem

    }
    
    init() {
        for _ in 0..<5{
            createItem()
        }
    }
}
