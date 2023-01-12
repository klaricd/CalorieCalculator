//
//  FoodEntry+CoreDataProperties.swift
//  Calorie Counter
//
//  Created by David Klaric on 10.01.2023..
//
//

import Foundation
import CoreData


extension FoodEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodEntry> {
        return NSFetchRequest<FoodEntry>(entityName: "FoodEntry")
    }

    @NSManaged public var foodName: String?
    @NSManaged public var foodCalories: String?

}

extension FoodEntry : Identifiable {

}
