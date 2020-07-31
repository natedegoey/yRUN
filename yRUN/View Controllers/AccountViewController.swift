//
//  AccountViewController.swift
//  yRUN
//
//  Created by Nathan DeGoey on 2020-07-26.
//  Copyright © 2020 Nathan DeGoey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var medalsLabel: UILabel!
    @IBOutlet weak var runsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var donatedLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Update the view so that the users information is displayed. This information is taken from the firestore database
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        // Check that the user is logged in and even has an account, which they should if they've made it here but good to check anyways.
        if uid != nil {
            db.collection("users").document(uid!).getDocument { (document, error) in
                if error == nil {
                    
                    //Check that this document exists in the users database
                    if document != nil && document!.exists {
                        // This gets a dict of all of the document data for the user
                        let documentData = document!.data()
                        // Now we can fetch our values!
                        self.nameLabel.text = "\(documentData?["firstname"] as! String) \(documentData?["lastname"] as! String)"
                        self.emailLabel.text = documentData?["email"] as? String
                        self.medalsLabel.text = "Medals: \(documentData?["totalmedals"] as! Int)"
                        self.runsLabel.text = "Runs: \(documentData?["totalruns"] as! Int)"
                        // Just to make sure that everything looks fine with the decimals
                        self.distanceLabel.text = "Total Distance: \(self.truncateDigitsAfterDecimal(number: documentData?["totalkms"] as! Double, afterDecimalDigits: 2)) kms"
                        self.donatedLabel.text = "Donated to Date: $\(self.truncateDigitsAfterDecimal(number: documentData?["totaldonated"] as! Double, afterDecimalDigits: 2))"
                    }
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // A helper method for truncating the digits of the runs distance parameter
    func truncateDigitsAfterDecimal(number: Double, afterDecimalDigits: Int) -> Double {
        if afterDecimalDigits < 1 || afterDecimalDigits > 512 {return 0.0}
        return Double(String(format: "%.\(afterDecimalDigits)f", number))!
    }

}
