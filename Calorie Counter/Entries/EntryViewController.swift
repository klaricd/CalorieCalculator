//
//  EntryViewController.swift
//  Calorie Counter
//
//  Created by David Klaric on 10.11.2022..
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var totalCalories: UILabel!
    
    // Totals
    @IBOutlet weak var bTotal: UILabel!
    @IBOutlet weak var lTotal: UILabel!
    @IBOutlet weak var dTotal: UILabel!
    @IBOutlet weak var sTotal: UILabel!
    
    // Breakfast
    @IBOutlet weak var bMeal1: UITextField!
    @IBOutlet weak var bMeal2: UITextField!
    @IBOutlet weak var bMeal3: UITextField!
    
    // Lunch
    @IBOutlet weak var lMeal1: UITextField!
    @IBOutlet weak var lMeal2: UITextField!
    @IBOutlet weak var lMeal3: UITextField!
    
    // Dinner
    @IBOutlet weak var dMeal1: UITextField!
    @IBOutlet weak var dMeal2: UITextField!
    @IBOutlet weak var dMeal3: UITextField!
    
    // Snacks
    @IBOutlet weak var sMeal1: UITextField!
    @IBOutlet weak var sMeal2: UITextField!
    @IBOutlet weak var sMeal3: UITextField!
    
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        setupEntry()
        setupNotificationCenter()
        
        self.hideKeyboardOnTap()
        }
    
    private func setupTextFields() {
        let textFields = [bMeal1, bMeal2, bMeal3, lMeal1, lMeal2, lMeal3, dMeal1, dMeal2, dMeal3, sMeal1, sMeal2, sMeal3]
        for textField in textFields {
            textField?.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        }
    }
    
    private func setupNotificationCenter() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func setupEntry() {
        guard let entry = entry else {
            // if you don't have existing entry, just create a new one and return
            self.entry = Entry(context: AppDelegate.shared.persistentContainer.viewContext)
            self.entry?.date = datePicker.date
            // if new entry textboxes are empty (no values entered), set total values to 0 (looks better)
            self.entry?.totalCalories = totalCalories.text ?? "0"
            self.entry?.breakfastTotal = bTotal.text ?? "0"
            self.entry?.lunchTotal = lTotal.text ?? "0"
            self.entry?.dinnerTotal = dTotal.text ?? "0"
            self.entry?.snacksTotal = sTotal.text ?? "0"
            return
        }
        
        // if there is existing entry, fill out text fields values
        totalCalories.text = entry.totalCalories
        bTotal.text = entry.breakfastTotal
        bMeal1.text = entry.breakfastMeal1
        bMeal2.text = entry.breakfastMeal2
        bMeal3.text = entry.breakfastMeal3
        lTotal.text = entry.lunchTotal
        lMeal1.text = entry.lunchMeal1
        lMeal2.text = entry.lunchMeal2
        lMeal3.text = entry.lunchMeal3
        dTotal.text = entry.dinnerTotal
        dMeal1.text = entry.dinnerMeal1
        dMeal2.text = entry.dinnerMeal2
        dMeal3.text = entry.dinnerMeal3
        sTotal.text = entry.snacksTotal
        sMeal1.text = entry.snacksMeal1
        sMeal2.text = entry.snacksMeal2
        sMeal3.text = entry.snacksMeal3
        
        if let dateToBeShown = entry.date {
            datePicker.date = dateToBeShown
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.shared.saveContext()
    }
    
    
    // MARK: - functions
    @objc func textChanged() {
        updateBreakfast()
        updateLunch()
        updateDinner()
        updateSnacks()
        updateTotal()
        updateEntry()
    }

    func updateBreakfast() {
        guard let meal1 = bMeal1.text,
              let meal2 = bMeal2.text,
              let meal3 = bMeal3.text
        else {
            print("An unexpected error happened while trying to convert breakfast values!")
            return
        }
        
        let value1 = Int(meal1) ?? 0
        let value2 = Int(meal2) ?? 0
        let value3 = Int(meal3) ?? 0
        bTotal.text = "\(value1 + value2 + value3)"
    }
    
    func updateLunch() {
        guard let meal1 = lMeal1.text,
              let meal2 = lMeal2.text,
              let meal3 = lMeal3.text
        else {
            print("An unexpected error happened while trying to convert lunch values!")
            return
        }
        
        let value1 = Int(meal1) ?? 0
        let value2 = Int(meal2) ?? 0
        let value3 = Int(meal3) ?? 0
        lTotal.text = "\(value1 + value2 + value3)"
    }
    
    func updateDinner() {
        guard let meal1 = dMeal1.text,
              let meal2 = dMeal2.text,
              let meal3 = dMeal3.text
        else {
            print("An unexpected error happened while trying to convert dinner values!")
            return
        }
        
        let value1 = Int(meal1) ?? 0
        let value2 = Int(meal2) ?? 0
        let value3 = Int(meal3) ?? 0
        dTotal.text = "\(value1 + value2 + value3)"
    }
    
    func updateSnacks() {
        guard let meal1 = sMeal1.text,
              let meal2 = sMeal2.text,
              let meal3 = sMeal3.text
        else {
            print("An unexpected error happened while trying to convert snacks values!")
            return
        }
        
        let value1 = Int(meal1) ?? 0
        let value2 = Int(meal2) ?? 0
        let value3 = Int(meal3) ?? 0
        sTotal.text = "\(value1 + value2 + value3)"
    }
    
    func updateTotal() {
        guard let totalB = bTotal.text,
              let totalL = lTotal.text,
              let totalD = dTotal.text,
              let totalS = sTotal.text
        else {
            print("An unexpected error happened while trying to convert total values!")
            return
        }
        
        let valueB = Int(totalB) ?? 0
        let valueL = Int(totalL) ?? 0
        let valueD = Int(totalD) ?? 0
        let valueS = Int(totalS) ?? 0
        totalCalories.text = "\(valueB + valueL + valueD + valueS)"
    }
    
    // this function just takes textField values and stores them to the Entry core data entity (or object)
    func updateEntry() {
        entry?.totalCalories = totalCalories.text
        entry?.breakfastTotal = bTotal.text
        entry?.breakfastMeal1 = bMeal1.text
        entry?.breakfastMeal2 = bMeal2.text
        entry?.breakfastMeal3 = bMeal3.text
        entry?.lunchTotal = lTotal.text
        entry?.lunchMeal1 = lMeal1.text
        entry?.lunchMeal2 = lMeal2.text
        entry?.lunchMeal3 = lMeal3.text
        entry?.dinnerTotal = dTotal.text
        entry?.dinnerMeal1 = dMeal1.text
        entry?.dinnerMeal2 = dMeal2.text
        entry?.dinnerMeal3 = dMeal3.text
        entry?.snacksTotal = sTotal.text
        entry?.snacksMeal1 = sMeal1.text
        entry?.snacksMeal2 = sMeal2.text
        entry?.snacksMeal3 = sMeal3.text

        // save context
        AppDelegate.shared.saveContext()
    }
    
    // this function adjust scroll view to fit keyboard
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    
    // MARK: - Button
    @IBAction func deleteButton(_ sender: Any) {
        guard let entry = entry else {
            navigationController?.popViewController(animated: true)
            return
        }
        let context = AppDelegate.shared.persistentContainer.viewContext
        context.delete(entry)
        try? context.save()
        navigationController?.popViewController(animated: true)
    }
}
