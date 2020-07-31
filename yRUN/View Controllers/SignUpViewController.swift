//
//  SignUpViewController.swift
//  yRUN
//
//  Created by Nathan DeGoey on 2020-07-26.
//  Copyright © 2020 Nathan DeGoey. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    

     override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            
            setUpElements()
        }
        
        func setUpElements() {
            
            // Hide the error label
            errorLabel.alpha = 0
            // Style the elements
            Utilities.styleTextField(firstNameTextField)
            Utilities.styleTextField(lastNameTextField)
            Utilities.styleTextField(emailTextField)
            Utilities.styleTextField(passwordTextField)
            Utilities.styleFilledButton(signUpButton)
        }

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */
        
        //Check the fields and validate that the data is correct. If everything is correct,
        // this method returns nil. Otherwise, returns the error message.
        func validateFields() -> String? {
            
            //Check thst all fields are filled in
            if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                
                return "Please fill in all fields"
            }
            
            // Check if the password is valid
            let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if Utilities.isPasswordValid(cleanedPassword) == false {
                //Password isn't secure enough
                return "Please make sure your password is at least 8 characters, contains a special character and a number"
            }
            
            return nil
        }
        
        @IBAction func signUpTapped(_ sender: Any) {
            
            //Validate the fields
            let error = validateFields()
            
            if error != nil {
                // There was an issue with the fields...show error message
                showError(error!)
            } else {
                
                //Create cleaned versions of the data
                let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
                //Create the user
                Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                    // Check for errors
                    if err != nil {
                        //There was an error creating the user
                        self.showError(err!.localizedDescription)
                    } else {
                        // User was created succesfully, store the first and last name.
                        let db = Firestore.firestore()
                        
                        // Here, I created the user with the uid as the address to find the user (something that is not default for firebase. This is very helpful later to easily grab the info for the user that is currently logged in from firestore. I am pretty proud of this trick.
                        db.collection("users").document(result!.user.uid).setData(["firstname":firstName, "lastname":lastName, "email":email, "password":password, "totalmedals":0, "uid":result!.user.uid, "totalruns":0, "totalkms":0.0, "totaldonated":0.0]) { (error) in
                            
                            if error != nil {
                                // Show error message
                                self.showError("Error saving user data")
                            }
                        }
                        //Transition to the main tab screen
                        self.transitionToHome()
                    }
                }
                
                
            }

        }
        
        func showError(_ message: String) {
            errorLabel.text = message
            errorLabel.alpha = 1
        }
        
        func transitionToHome() {
            
            let tabViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabViewController) as? TabViewController
            
            view.window?.rootViewController = tabViewController
            view.window?.makeKeyAndVisible()
            
        }

    }
