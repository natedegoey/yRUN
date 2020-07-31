//
//  SavedRunsViewController.swift
//  yRUN
//
//  Created by Nathan DeGoey on 2020-07-29.
//  Copyright © 2020 Nathan DeGoey. All rights reserved.
/*
 One thing to note about this file.
 While I was able to get the run information to save on the device using Core Data, this means that the saved runs are based on the device, not the specific user. For the most part, this is okay, since everyone just runs with their own phone, but this is something that I would like to fix in future releases of the app.
 */

import UIKit
import CoreData

class SavedRunsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            
            tableView.delegate = self
            tableView.dataSource = self
        }
        

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */
    
    private func getRuns() -> [Run] {
      let fetchRequest: NSFetchRequest<Run> = Run.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Run.timestamp), ascending: true)
      fetchRequest.sortDescriptors = [sortDescriptor]
      do {
        return try CoreDataStack.context.fetch(fetchRequest)
      } catch {
        return []
      }
    }
    
    // A helper method for truncating the digits of the runs distance parameter
    func truncateDigitsAfterDecimal(number: Double, afterDecimalDigits: Int) -> Double {
        if afterDecimalDigits < 1 || afterDecimalDigits > 512 {return 0.0}
        return Double(String(format: "%.\(afterDecimalDigits)f", number))!
    }


}

    extension SavedRunsViewController: UITableViewDelegate {
        
        // func for what to do when a specific row is selected
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = UIViewController()
            vc.view.backgroundColor = .red
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    extension SavedRunsViewController: UITableViewDataSource {
        // Fill the table view with saved runs, as many as there are that have been saved on this device
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return getRuns().count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: RunCell = tableView.dequeueReusableCell(withIdentifier: "runcell", for: indexPath) as! RunCell
            let currentRun = getRuns()[indexPath.row]
            // Date formatter for ease of use with the runs timestamp
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            cell.dateLabel.text = formatter.string(for: currentRun.timestamp)
            
            let kmdistance = currentRun.distance / 1000 // get the distance in km's from meters and display it below
            cell.distanceLabel.text = "Distance: \(truncateDigitsAfterDecimal(number: kmdistance, afterDecimalDigits: 2)) kms"
            
            let timeminutes = currentRun.duration / 60
            let timeseconds = currentRun.duration % 60
            cell.durationLabel.text = "Time: \(timeminutes):\(timeseconds)"
            return cell
        }
        
    }
