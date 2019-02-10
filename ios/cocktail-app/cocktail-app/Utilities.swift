//
//  Utilities.swift
//  cocktail-app
//
//  Created by Colin Watson on 2/9/19.
//  Copyright © 2019 Colin Watson. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    static func setImageFromUrl(url: String, imageView: UIImageView) {
        let url: String = (URL(string: url)?.absoluteString)!
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {
        (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
    
            DispatchQueue.main.async(execute: {
                let image = UIImage(data:data!)!
                imageView.image = image
            })
        }).resume()
    }
}
