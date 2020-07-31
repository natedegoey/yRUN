//
//  LoginViewController.swift
//  yRUN
//
//  Created by Nathan DeGoey on 2020-07-26.
//  Copyright © 2020 Nathan DeGoey. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            
            setUpElements()
        }
        
        func setUpElements() {
            
            // Hide the error label
            errorLabel.alpha = 0
            
            //Style the elements
            Utilities.styleTextField(emailTextField)
            Utilities.styleTextField(passwordTextField)
            Utilities.styleFilledButton(loginButton)
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
            if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                
                return "Please fill in all fields"
            }
            
            return nil
        }
        
    @IBAction func loginButtonTapped(_ sender: Any) {
        // TODO: Validate Text Fields
                   let error = validateFields()
                          
                   if error != nil {
                   // There was an issue with the fields...show error message
                           showError(error!)
                   } else {
                          // Create cleaned versions of the text field
                          let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                          let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                          
                          // Signing in the user
                          Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                              
                              if error != nil {
                                  // Couldn't sign in
                                  self.errorLabel.text = error!.localizedDescription
                                  self.errorLabel.alpha = 1
                              }
                              else {
                                  
                                // Go to the main screen tab view
                                  let tabViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabViewController) as? TabViewController
                                
                                  self.view.window?.rootViewController = tabViewController
                                  self.view.window?.makeKeyAndVisible()
                              }
                          }
                   }
    }
        
        func showError(_ message: String) {
            errorLabel.text = message
            errorLabel.alpha = 1
        }
    }
