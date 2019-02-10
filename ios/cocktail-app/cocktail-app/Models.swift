//
//  Drink.swift
//  cocktail-app
//
//  Created by Colin Watson on 2/8/19.
//  Copyright © 2019 Colin Watson. All rights reserved.
//

import Foundation


class DrinkJson: Decodable {
    var title: String = ""
    var description: String = ""
    var imageUrl: String = ""
    var ingredients: [IngredientJson] = []
    var sections: [SectionJson] = []
}

class IngredientJson: Decodable
{
    var amount: String = ""
    var name: String = ""
}


class SectionJson: Decodable
{
    var title: String = ""
    var content: String = ""
}
