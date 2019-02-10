//
//  DrinkRepository.swift
//  cocktail-app
//
//  Created by Colin Watson on 2/9/19.
//  Copyright © 2019 Colin Watson. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DrinkRepository {
    
    
    func findByTitle(title: String)->Drink? {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<Drink>(entityName: Drink.entityName)
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        fetchRequest.relationshipKeyPathsForPrefetching = ["ingredients"]
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            if results.count > 0 {
                return results[0]
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    static func getAllDrinks() -> [Drink]? {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<Drink>(entityName: Drink.entityName)
        
        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    static func resetAllRecords(in entity : String)
    {
        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
    
    static func seedData() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        DrinkRepository.resetAllRecords(in: Section.entityName)
        DrinkRepository.resetAllRecords(in: Ingredient.entityName)
        DrinkRepository.resetAllRecords(in: Drink.entityName)
    
        let drinksJson = loadJson(filename: "drinks")!
        
        let entity =
            NSEntityDescription.entity(forEntityName: Drink.entityName,
                                       in: managedContext)!
        
        let drink = NSManagedObject(entity: entity,
                                    insertInto: managedContext) as! Drink
        for d in drinksJson {
            
            drink.title = d.title
            drink.drinkDescription = d.description
            drink.imageUrl = d.imageUrl
            
            for ingredient in d.ingredients {
                
                let ingredientEntity =
                    NSEntityDescription.insertNewObject(
                        forEntityName: Ingredient.entityName,
                        into: managedContext)
                        as! Ingredient
                
                ingredientEntity.name = ingredient.name
                ingredientEntity.amount = ingredient.amount
                ingredientEntity.drink = drink
            }
            
            
            for section in d.sections {
                
                let sectionEntity =
                    NSEntityDescription.insertNewObject(
                        forEntityName: Section.entityName,
                        into: managedContext)
                        as! Section
                
                sectionEntity.title = section.title
                sectionEntity.content = section.content
                sectionEntity.drink = drink
            }
        }
        
        do {
            try managedContext.save()
        }
        catch {
            print("error saving drink")
        }
        _ = drink.ingredients?.count
    }
    
    
    static func loadJson(filename fileName: String) -> [DrinkJson]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                return jsonData.drinks
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

