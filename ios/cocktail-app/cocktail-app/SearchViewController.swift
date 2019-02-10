//
//  SearchViewController.swift
//  cocktail-app
//
//  Created by Colin Watson on 2/8/19.
//  Copyright © 2019 Colin Watson. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var searchText: UITextField!
    @IBOutlet var tableView: UITableView!
    
    var searchResults: [NSManagedObject] = []
    
    @IBAction func search (sender: UIButton) {
        print("searching...")
        let searchTerm = searchText.text!
        if searchTerm.count > 2 {
            searchDrinks(searchTerm: searchTerm)
        }
    }
    
    func searchDrinks(searchTerm: String) {
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "DrinkEntity")
        fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchTerm)
        
        //3
        do {
            searchResults = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        print(searchResults.count)
        
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search Results"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drinkCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        let i: Int = indexPath.row
        
        drinkCell.favButton.tag = i;
        
        let result = searchResults[i];
        
        drinkCell.drinkTitle.text = result.value(forKeyPath: "title") as? String
        drinkCell.drinkDescription.text = result.value(forKeyPath: "desc") as? String
        displayDrinkImage(i, drinkCell: drinkCell)
        
        return drinkCell
    }
    
    func displayDrinkImage(_ row: Int, drinkCell: CustomTableViewCell) {
        let result = searchResults[row];
        Utilities.setImageFromUrl(url: result.value(forKeyPath: "imageUrl") as! String, imageView: drinkCell.drinkImageView)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
