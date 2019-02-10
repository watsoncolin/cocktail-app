//
//  DrinkDetailsViewController.swift
//  cocktail-app
//
//  Created by Colin Watson on 2/9/19.
//  Copyright © 2019 Colin Watson. All rights reserved.
//

import UIKit

class DrinkDetailsViewController: UIViewController {
    @IBOutlet var DrinkImage: UIImageView!
    @IBOutlet var DrinkDescription: UILabel!
    @IBOutlet var DrinkTitle: UILabel!
    @IBOutlet var Ingredients: UILabel!
    @IBOutlet var SectionView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let repository = DrinkRepository()
        
        let drink = repository.findByTitle(title: self.title!)
        
        if drink == nil{
            _ = self.navigationController?.popToRootViewController(animated: true)
            return
        }
        
        DrinkTitle.text = drink!.title
        DrinkDescription.text = drink!.drinkDescription
        
        Ingredients.text = (drink?.ingredients?.allObjects as! [Ingredient]).map {"\($0.amount!) \($0.name!)"}.joined(separator: "\r\n")
                        
        Utilities.setImageFromUrl(url: drink!.imageUrl!, imageView: DrinkImage)
        
        
        var previousBounds = Ingredients.bounds
        var previousFrame = Ingredients.frame
        
        for section in (drink!.sections?.allObjects as! [Section]) {
            let sectionTitle = UILabel(frame: CGRect(x: 0, y: 0,
                                              width: previousBounds.width,
                                              height: DrinkTitle.bounds.height))

            sectionTitle.center = CGPoint(x: previousFrame.origin.x + previousBounds.width / 2,
                                   y: previousFrame.origin.y + previousBounds.height + 60)

            sectionTitle.font = DrinkTitle.font
            sectionTitle.textAlignment = .center
            sectionTitle.text = section.title

            self.view.addSubview(sectionTitle)
            
            previousFrame = sectionTitle.frame
            previousBounds = sectionTitle.bounds
            
            let sectionContent = UILabel(frame: CGRect(x: 0, y: 0,
                                                     width: previousBounds.width,
                                                     height: DrinkTitle.bounds.height))
            
            sectionContent.center = CGPoint(x: previousFrame.origin.x + previousBounds.width / 2,
                                          y: previousFrame.origin.y + previousBounds.height + 50)
            
            
            sectionContent.font = DrinkDescription.font
            sectionContent.textAlignment = .left
            sectionContent.numberOfLines = 0
            sectionContent.lineBreakMode = .byWordWrapping
            
            let attrStr = try! NSAttributedString(
                data: section.content!.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            
            sectionContent.attributedText = attrStr
            sectionContent.sizeToFit()
            
            self.view.addSubview(sectionContent)
            
            previousBounds = sectionContent.bounds
            previousFrame = sectionContent.frame
            
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
