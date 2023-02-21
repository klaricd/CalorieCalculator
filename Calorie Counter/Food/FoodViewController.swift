//
//  FoodViewController.swift
//  Calorie Counter
//
//  Created by David Klaric on 09.01.2023..
//

import UIKit

class FoodViewController: UIViewController {

    @IBOutlet weak var foodName: UITextField!
    @IBOutlet weak var foodCalories: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardOnTap()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        // make entry
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let foodEntry = FoodEntry(context: context)
            foodEntry.foodName = foodName.text
            foodEntry.foodCalories = foodCalories.text
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        
        // segue to table view
        navigationController?.popViewController(animated: true)
    }
}
