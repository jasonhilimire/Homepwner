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
    
    //Construct a file URL
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    // save the changes to the File URL
    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")

        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
        
    }
    

    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            allItems = archivedItems
        }
    }
    


    
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
