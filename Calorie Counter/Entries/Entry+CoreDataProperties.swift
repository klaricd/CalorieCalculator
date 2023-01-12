//
//  Entry+CoreDataProperties.swift
//  Calorie Counter
//
//  Created by David Klaric on 10.01.2023..
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var breakfastMeal1: String?
    @NSManaged public var breakfastMeal2: String?
    @NSManaged public var breakfastMeal3: String?
    @NSManaged public var breakfastTotal: String?
    @NSManaged public var date: Date?
    @NSManaged public var dinnerMeal1: String?
    @NSManaged public var dinnerMeal2: String?
    @NSManaged public var dinnerMeal3: String?
    @NSManaged public var dinnerTotal: String?
    @NSManaged public var goalCalories: String?
    @NSManaged public var lunchMeal1: String?
    @NSManaged public var lunchMeal2: String?
    @NSManaged public var lunchMeal3: String?
    @NSManaged public var lunchTotal: String?
    @NSManaged public var snacksMeal1: String?
    @NSManaged public var snacksMeal2: String?
    @NSManaged public var snacksMeal3: String?
    @NSManaged public var snacksTotal: String?
    @NSManaged public var totalCalories: String?

}

extension Entry : Identifiable {
    
    func month() -> String {
     let formatter = DateFormatter()
     formatter.dateFormat = "MMM"
     if let dateToBeFormatted = date {
         let month = formatter.string(from: dateToBeFormatted)
         return month.uppercased()
     }
     return ""
    }

    func day() -> String {
     let formatter = DateFormatter()
     formatter.dateFormat = "d"
     if let dateToBeFormatted = date {
         let day = formatter.string(from: dateToBeFormatted)
         return day
     }
     return ""
    }

}
