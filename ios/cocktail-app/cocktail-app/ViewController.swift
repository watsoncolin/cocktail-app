//
//  ViewController.swift
//  cocktail-app
//
//  Created by Colin Watson on 2/8/19.
//  Copyright © 2019 Colin Watson. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var favoriteDrinks: [Drink] = []
    @IBOutlet var mainTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteDrinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drinkCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        let i: Int = indexPath.row
        
        let result = favoriteDrinks[i];
        
        drinkCell.drinkTitle.text = result.title
        drinkCell.drinkDescription.text = result.drinkDescription
        displayDrinkImage(i, drinkCell: drinkCell)
        
        return drinkCell
    }
    
    
    func displayDrinkImage(_ row: Int, drinkCell: CustomTableViewCell) {
        let result = favoriteDrinks[row];
        Utilities.setImageFromUrl(url: result.imageUrl!, imageView: drinkCell.drinkImageView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        mainTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DrinkRepository.seedData()
        let drinks = DrinkRepository.getAllDrinks()
        favoriteDrinks = drinks!
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let controller = segue.destination as! DrinkDetailsViewController
            let cell = sender as! CustomTableViewCell
            controller.title = cell.drinkTitle.text
        }
    }
    
    
    
}

struct ResponseData: Decodable {
    var drinks: [DrinkJson]
}

