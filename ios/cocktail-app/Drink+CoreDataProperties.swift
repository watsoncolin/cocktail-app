//
//  Drink+CoreDataProperties.swift
//  cocktail-app
//
//  Created by Colin Watson on 2/9/19.
//  Copyright © 2019 Colin Watson. All rights reserved.
//
//

import Foundation
import CoreData


extension Drink {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Drink> {
        return NSFetchRequest<Drink>(entityName: "Drink")
    }

    @NSManaged public var drinkDescription: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var imageUrl: String?
    @NSManaged public var title: String?
    @NSManaged public var ingredients: NSSet?
    @NSManaged public var sections: NSSet?

}

// MARK: Generated accessors for ingredients
extension Drink {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: Ingredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: Ingredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

// MARK: Generated accessors for sections
extension Drink {

    @objc(addSectionsObject:)
    @NSManaged public func addToSections(_ value: Section)

    @objc(removeSectionsObject:)
    @NSManaged public func removeFromSections(_ value: Section)

    @objc(addSections:)
    @NSManaged public func addToSections(_ values: NSSet)

    @objc(removeSections:)
    @NSManaged public func removeFromSections(_ values: NSSet)

}
