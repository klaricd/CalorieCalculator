//
//  EntriesTableViewController.swift
//  Calorie Counter
//
//  Created by David Klaric on 10.11.2022..
//

import UIKit
import CoreData

class EntriesTableViewController: UITableViewController {
    
    var entries: [Entry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let request: NSFetchRequest<Entry> = Entry.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
            
            if let entriesFromCoreData = try? context.fetch(request) as [Entry] {
                entries = entriesFromCoreData
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell") as? EntryTableViewCell {
            
            let entry = entries[indexPath.row]
            
            cell.calorieLabel.text = entry.totalCalories
            // calorie goal customization will be on next app version :)
            cell.goalLabel.text = "2800"
            cell.dayLabel.text = entry.day()
            cell.monthLabel.text = entry.month()
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = entries[indexPath.row]
        performSegue(withIdentifier: "segueToEntry", sender: entry)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let entryVC = segue.destination as? EntryViewController {
            if let entryToBeSent = sender as? Entry {
                entryVC.entry = entryToBeSent
            }
        }
    }
}
