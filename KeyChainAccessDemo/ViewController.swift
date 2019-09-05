//
//  ViewController.swift
//  KeyChainAccessDemo
//
//  Created by Prashanth on 05/09/19.
//  Copyright © 2019 Prashanth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let service = "myService"
    let account = "myAccount"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // will only work after
    @IBAction func updatePassword(_ sender: Any) {
        KeychainService.updatePassword(service: service, account: account, data: passwordTextField.text ?? "")
    }
    
    @IBAction func removePassword(_ sender: Any) {
        KeychainService.removePassword(service: service, account: account)
    }
    
    @IBAction func passwordSet(_ sender: Any) {
        let password = passwordTextField.text ?? ""
        KeychainService.savePassword(service: service, account: account, data: password)
    }
    
    @IBAction func passwordGet(_ sender: Any) {
        if let str = KeychainService.loadPassword(service: service, account: account) {
            print("Password:- \(str)")
            passwordTextField.text = str
        }
        else {passwordTextField.text = "Password does not exist" }
    }

}

