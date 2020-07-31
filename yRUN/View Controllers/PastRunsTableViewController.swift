//
//  PastRunsTableViewController.swift
//  yRUN
//
//  Created by Nathan DeGoey on 2020-07-29.
//  Copyright © 2020 Nathan DeGoey. All rights reserved.
//

import UIKit
import CoreData

class PastRunsTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
      getRuns()
    }

    // returns a list of all completed runs, sorted by date.
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
}

extension PastRunsTableViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return getRuns().count
  }
}
