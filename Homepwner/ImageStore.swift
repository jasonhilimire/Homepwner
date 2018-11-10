//
//  ImageStore.swift
//  Homepwner
//
//  Created by Jason Hilimire on 11/9/18.
//  Copyright © 2018 Peanut Apps. All rights reserved.
//

import UIKit

class ImageStore  {
    let cache = NSCache<NSString,UIImage>()
    
    func setImage(_ image: UIImage, forKey key:String) {
        cache.setObject(image, forKey: key as NSString)
        
        // Create a full URL for image
        let url = imageURL(forKey: key)
        
        //Turn image into JPEG dta
        if let data = image.jpegData(compressionQuality: 0.5) {
            // write to full IRL
            let _ = try? data.write(to: url, options: [.atomic])
        }
    }
    
    func image(forKey key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
         cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        do {
         try FileManager.default.removeItem(at: url)
        } catch let deleteError {
            print("Error removing image from disk \(deleteError)")
        }
    }
    
    //save the images to a URL
    func imageURL (forKey key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
        
    }
}
