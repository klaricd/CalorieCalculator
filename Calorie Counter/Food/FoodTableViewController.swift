//
//  FoodTableViewController.swift
//  Calorie Counter
//
//  Created by David Klaric on 09.01.2023..
//

import UIKit
import CoreData

class FoodTableViewController: UITableViewController {
    
    var foodEntries: [FoodEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        self.tableView.isEditing = true
        fetchCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            // sort tableview rows in food list
            //request.sortDescriptors = [NSSortDescriptor(key: "", ascending: true)]
            let request: NSFetchRequest<FoodEntry> = FoodEntry.fetchRequest()
            
            if let entriesFromCoreData = try? context.fetch(request) {
                foodEntries = entriesFromCoreData
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodEntries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FoodEntryCell") as? FoodTableViewCell {
            
            let foodentry = foodEntries[indexPath.row]
            
            cell.foodNameLabel.text = foodentry.foodName
            cell.foodCalorieLabel.text = ("\(foodentry.foodCalories ?? "0") kcal")
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = AppDelegate.shared.persistentContainer.viewContext

        if editingStyle == .delete {
            let entryToDelete = foodEntries[indexPath.row]
            context.delete(entryToDelete)
            
            foodEntries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                // save context
                try context.save()
            } catch let error as NSError {
                print("Error while deleting: \(error)")
            }
        }
    }
    
    // MARK: - Functions
    
    func fetchCoreData() {
        // fetch FoodEntry object from coredata
        let context = AppDelegate.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<FoodEntry>(entityName: "FoodEntry")
        do {
            foodEntries = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch! \(error)")
        }
    }
}
