//
//  CharityInfoViewController.swift
//  yRUN
//
//  Created by Nathan DeGoey on 2020-07-30.
//  Copyright © 2020 Nathan DeGoey. All rights reserved.
//

import UIKit

class CharityInfoViewController: UIViewController {
    
    @IBOutlet weak var charityName: UILabel!
    @IBOutlet weak var foundedDate: UILabel!
    @IBOutlet weak var hqLocation: UILabel!
    @IBOutlet weak var biography: UILabel!
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var urlLabel: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // For now, load the view ith info on the Ronals McDonal House Charity
        // TODO: connect to firebase so that a list of all the charities linked with the app will be dispalyed in the table view cell, and the information here will be referencing the information stored in firebase for each charity
        logoView.image = UIImage(named: "RHMClogo")
        charityName.text = "Ronald McDonald House Charities"
        foundedDate.text = "Founded: October 15, 1974"
        hqLocation.text = "HQ: Chicago, Illinois, USA"
        biography.text = "Keeping families of sick children together and close to the care they need."
        // Set the url text and define it as a link
        urlLabel.text = "https://www.rmhccanada.ca/why-rmhc"
        urlLabel.isEditable = false
        urlLabel.dataDetectorTypes = .link
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // A function for what happens when the user clicks donate
    @IBAction func donateTapped(_ sender: Any) {
    }
    

}
