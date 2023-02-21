//
//  CalculatorViewController.swift
//  Calorie Counter
//
//  Created by David Klaric on 12.01.2023..
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var ageInput: UITextField!
    @IBOutlet weak var genderInput: UISegmentedControl!
    @IBOutlet weak var weightInput: UITextField!
    @IBOutlet weak var heightInput: UITextField!
    @IBOutlet weak var goalInput: UISegmentedControl!
    @IBOutlet weak var exerciseLevelInput: UITextField!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    var exerciseLevelList = ["Little/no exercise", "Light exercise (1-3 per week)", "Moderate exercise (3-5 per week)", "Hard exercise (6-7 per week)", "Very hard exercise/physical job/sports"]
    let pickerView = UIPickerView()
    var statementsExecuted = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        exerciseLevelInput.inputView = pickerView
        textLabel.isHidden = true
        
        self.hideKeyboardOnTap()
    }
    
    // MARK: - Button
    @IBAction func calculateButton(_ sender: Any) {
        inputCheck()
        //valueCheck()
        if !statementsExecuted {
            exerciseCases()
            saveString()
            textLabel.isHidden = false
        }
    }
    
    // MARK: - Functions
    func exerciseCases() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        switch selectedRow {
        case 0:
            if genderInput.selectedSegmentIndex == 0 {
                maleBMR(activityFactor: 1.2)
            } else {
                femaleBMR(activityFactor: 1.2)
            }
        case 1:
            if genderInput.selectedSegmentIndex == 0 {
                maleBMR(activityFactor: 1.375)
            } else {
                femaleBMR(activityFactor: 1.375)
            }
        case 2:
            if genderInput.selectedSegmentIndex == 0 {
                maleBMR(activityFactor: 1.55)
            } else {
                femaleBMR(activityFactor: 1.55)
            }
        case 3:
            if genderInput.selectedSegmentIndex == 0 {
                maleBMR(activityFactor: 1.725)
            } else {
                femaleBMR(activityFactor: 1.725)
            }
        case 4:
            if genderInput.selectedSegmentIndex == 0 {
                maleBMR(activityFactor: 1.9)
            } else {
                femaleBMR(activityFactor: 1.9)
            }
        default:
            break
        }
    }
    
    func inputCheck() {
        if ageInput.text == "" {
            let alert = UIAlertController(title: "Age? 👀", message: "You must enter your age!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            statementsExecuted = true
        }
        else if weightInput.text == "" {
            let alert = UIAlertController(title: "Weight? 👀", message: "You must enter your weight!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            statementsExecuted = true
        }
        else if heightInput.text == "" {
            let alert = UIAlertController(title: "Height? 👀", message: "You must enter your height!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            statementsExecuted = true
        } else {
            statementsExecuted = false
            return
        }
    }
    
    // check user input values, this app is not intended for children use
    // currently not using this function, have to adjust it appropriately (will include in later updates)
    
    /*func valueCheck() {
        let ageValue = Int(ageInput.text!) ?? 0
        let weightValue = Int(weightInput.text!) ?? 0
        let heightValue = Int(heightInput.text!) ?? 0
        
        if ageValue < 10 {
            let alert = UIAlertController(title: "Age? 👀", message: "This calculator is not intended for children.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            statementsExecuted = true
        }
        else if weightValue < 20 {
            let alert = UIAlertController(title: "Weight? 👀", message: "This weight suggests a very young person. Calculator is not intended for children.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            statementsExecuted = true
        }
        else if heightValue < 50 {
            let alert = UIAlertController(title: "Height? 👀", message: "This calculator is not intended for children.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            statementsExecuted = true
        } else {
            return
        }
    }*/
    
    func saveString() {
        let string = goalLabel.text
        // save the value from label to UserDefaults
        UserDefaults.standard.set(string, forKey: "savedString")
    }
    
    func maleBMR(activityFactor: Double) {
        var mBMR: Double = 0
        guard let ageInput = ageInput.text,
              let weightInput = weightInput.text,
              let heightInput = heightInput.text
        else {
            print("An unexpected error happend with male BMR")
            return
        }
        
        let age = Double(ageInput) ?? 0
        let weight = Double(weightInput) ?? 0
        let height = Double(heightInput) ?? 0
        
        let w = 13.75 * weight
        let h = 5.003 * height
        let a = 6.75 * age
        mBMR = 66.5 + w + h - a
        
        if goalInput.selectedSegmentIndex == 0 {
            mBMR = ((mBMR - 250) * activityFactor)
            let result = Int(mBMR)
            goalLabel.text = "\(result)"
            print(mBMR)
        } else {
            mBMR = ((mBMR + 250) * activityFactor)
            let result = Int(mBMR)
            goalLabel.text = "\(result)"
            print(mBMR)
        }
    }
    
    func femaleBMR(activityFactor: Double) {
        var wBMR: Double = 0
        guard let ageInput = ageInput.text,
              let weightInput = weightInput.text,
              let heightInput = heightInput.text
        else {
            print("An unexpected error happend with female BMR")
            return
        }
        
        let age = Double(ageInput) ?? 0
        let weight = Double(weightInput) ?? 0
        let height = Double(heightInput) ?? 0
        
        let w = 9.563 * weight
        let h = 1.850 * height
        let a = 4.676 * age
        wBMR = 665.1 + w + h - a
        
        if goalInput.selectedSegmentIndex == 0 {
            wBMR = ((wBMR - 250) * activityFactor)
            let result = Int(wBMR)
            goalLabel.text = "\(result)"
            print(wBMR)
        } else {
            wBMR = ((wBMR + 250) * activityFactor)
            let result = Int(wBMR)
            goalLabel.text = "\(result)"
            print(wBMR)
        }
    }
}

// MARK: - Extension
extension CalculatorViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exerciseLevelList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return exerciseLevelList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        exerciseLevelInput.text = exerciseLevelList[row]
    }
}
