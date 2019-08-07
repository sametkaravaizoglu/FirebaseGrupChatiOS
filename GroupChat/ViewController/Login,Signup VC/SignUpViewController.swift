//
//  SignUpViewController.swift
//  GroupChat
//
//  Created by KandyClients on 22.07.2019.
//  Copyright © 2019 KandyClients. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Foundation


class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func CancelDidTapped(_ sender: Any) {
        dismiss(animated: true,completion:nil)
    }
    
    
    @IBAction func SignUpDidTapped2(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty, let username = usernameTextField.text, !username.isEmpty else{
            return
        }
        DataService.dataService.SignUp(username: username, email: email, password: password)
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil && user != nil {
                print("User Created")
            }else {
                print("Fail :/")
            }
        }
    }
}
