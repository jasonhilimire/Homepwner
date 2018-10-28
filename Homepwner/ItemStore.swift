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
    

    
    @discardableResult func createItem() -> Item {
    let newItem = Item(random: true)
    
    allItems.append(newItem)
    
    return newItem

    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    
    // enable moving an item
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        //Get refrence to object being moved so can reinsert
        let movedItem = allItems[fromIndex]
        
        //Remove from Aray
        allItems.remove(at: fromIndex)
        
        //Insert into new location
        allItems.insert(movedItem, at: toIndex)
    }

}
