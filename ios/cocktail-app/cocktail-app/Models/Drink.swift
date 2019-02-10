//
//  Drink.swift
//  cocktail-app
//
//  Created by Colin Watson on 2/9/19.
//  Copyright © 2019 Colin Watson. All rights reserved.
//

import Foundation
import CoreData

class Drink: NSManagedObject {
    @NSManaged var title: String?
    @NSManaged var drinkDescription: String?
    @NSManaged var imageUrl: String?
    @NSManaged var favorite: Bool
    @NSManaged var ingredients: NSSet?
    @NSManaged var sections: NSSet?
    
    static var entityName: String { return "Drink" }
}

class Ingredient: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var amount: String?
    @NSManaged var drink: Drink
    static var entityName: String { return "Ingredient" }
}

class Section: NSManagedObject {
    @NSManaged var title: String?
    @NSManaged var content: String?
    @NSManaged var drink: Drink
    static var entityName: String { return "Section" }
}
