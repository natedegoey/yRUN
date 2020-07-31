//
//  CharityViewController.swift
//  yRUN
//
//  Created by Nathan DeGoey on 2020-07-26.
//  Copyright © 2020 Nathan DeGoey. All rights reserved.
/*
 A note about this file. This file will eventually show a list of charities around the world (with their logos attached). I would also like to incorporate a search bar to search for your desired charity. Once a charity is tapped, another viewController will open up, giving much more detail on the charity, a little biography of the charity includng founding year, location of headquarters, etc.. This page will also have a link to the charities website. On these pages, the user can choose to donate their medals (as long as they have at least 1000 medals ($1 CAD at the minimum (hopefully with more funding and success this number can increase), which is the equivalent of running 10 kilometres. Once this button is selected, a message will pop up asking the user to confirm cashing in their medals. Once the user agrees, this request will be sent through an automated system that donates the money straight to the charity (still working on the details for that). There will also be a variable for each charity that says how much money has been raised by yRUN runners for that charity to date.
 */
//

import UIKit
import Firebase
import FirebaseAuth

class CharityViewController: UIViewController {
    
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
    

}
extension CharityViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let charityInfoViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.charityInfoViewController) as! CharityInfoViewController
        //Idea...have a background colour property in the firebase for each charity, so that the background colour fits with the chairty colours. Ex. Ronald McDonald House Charities page would have a background colour of red. IT would be implemented like charityInforViewController.view.backgroundColor = .(firestorebackgroundcolourpath)
        
        navigationController?.pushViewController(charityInfoViewController, animated: true)
    }
}

extension CharityViewController: UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //TODO: Implementation for getting list of Charities from firestore. Doesn't work right now
        //let db = Firestore.firestore()
        //var numChar = 0
        //db.collection("users").getDocuments() { (snapshot, error) in
          //  if error == nil {
            //    numChar += snapshot!.count
            //} else {
             //   print("Error getting documents")
            //}
        //}
        // will return zero if there are errors retreiving above information
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charitycell", for: indexPath)
        
        cell.textLabel?.text = "Ronald McDonald House Charities"
        
        return cell
    }
    
}
