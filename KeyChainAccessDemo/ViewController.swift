//
//  ViewController.swift
//  KeyChainAccessDemo
//
//  Created by Prashanth on 05/09/19.
//  Copyright © 2019 Prashanth. All rights reserved.
//

import UIKit

var startDate:Date?

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let service = "myService"
    let account = "myAccount"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startDate = Date()
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
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let endDate = Date()
        self.isSessionExpired(start: startDate!, end: endDate)
    }

}

//MARK:- for session expiration
extension UIViewController{
    func isSessionExpired(start: Date, end: Date){
        
        if self.getDateDiff(start: start, end: end) >= 15 {
            let alert = UIAlertController(title: "", message: "Session Warning...!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (warningAction) in
                print("Seesion Expired")
                startDate = end
            }))
            self.present(alert, animated: true, completion: nil)
        }else{
            startDate = end
            
        }
    }
    func getDateDiff(start: Date, end: Date) -> Int  {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([Calendar.Component.second], from: start, to: end)
        
        let seconds = dateComponents.second
        return Int(seconds!)
    }
}
