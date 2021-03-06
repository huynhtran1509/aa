//
//  Player.swift
//  2for1
//
//  Created by Douglas Galante on 12/25/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

extension Player {
    
    var playerImage: UIImage {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        if let file = file {
            let filePath = documentsURL.appendingPathComponent(file).path
            if FileManager.default.fileExists(atPath: filePath) {
                if let image = UIImage(contentsOfFile: filePath) {
                    return image                    
                } else {
                    print("players image returned nil at designated file path")
                }
            }
        }
        return #imageLiteral(resourceName: "slime")
    }
    
    
}
