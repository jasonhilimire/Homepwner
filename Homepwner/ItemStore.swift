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
//    func saveChanges() -> Bool {
//        print("Saving items to: \(itemArchiveURL.path)")
//
//        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
//        
//    }
    
    // Rewritten as ^^ is deprecated
    func saveChanges() {
        print("Saving items to: \(itemArchiveURL.path)")
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: allItems, requiringSecureCoding: false)
            try data.write(to: itemArchiveURL)
        } catch {
            print("Couldn't write file")
        }
    }
    
    // Initialize: however this was deprecatd in iOS12 and i cant make it fucking work
//    init() {
//        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
//            allItems = archivedItems
//        }
//    }
    
    init() {
        if let unarchivedItems = UserDefaults.standard.object(forKey: itemArchiveURL.path) as? Data {
            if let archivedItems = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSDictionary.self, Item.self], from: unarchivedItems) {
                allItems = archivedItems as! [Item]
            }
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
