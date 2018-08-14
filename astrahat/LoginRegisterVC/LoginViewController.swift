//
//  LoginViewController.swift
//  astrahat
//
//  Created by on on 8/8/18.
//  Copyright © 2018 on. All rights reserved.
//

import UIKit
import ObjectMapper
class LoginViewController: UIViewController {

    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtn.layer.cornerRadius = loginBtn.frame.size.height/2
        loginBtn.clipsToBounds = true
        phoneTF.text = "00966504411432"
        passTF.text = "123456"
    }

    @IBAction func loginBtnTapped(_ sender: Any) {
        if phoneTF.text == "" || passTF.text == "" {
            
            showAlert(message: "برجاء الموافقه علي شروط الاستخدام")
            return
        }
        let manger = ServerManager()
        let params = ["username" : phoneTF.text!,
                      "password": passTF.text!,
                      "firebase": "test",
                      "scope": "*",
                      "grant_type" :"password",
                      "client_id" : "2",
                      "client_secret" : "Xlrl5lzzLsmCinUQDfxMAVv64oQxHDs4SURIMitV"] as [String : AnyObject]
        manger.perform(methodType: .post, needToken: false, serviceName: .login, parameters: params){
            (JSON, String) -> Void in
            if String != nil {
                self.showAlert(message: String!)
            } else {
                let response = JSON as! NSDictionary
                var userData = Mapper<UserData>().mapArray(JSONObject: response["data"] as Any)
                let userdef = UserDefaults.standard
                userdef.set(response["access_token"], forKey: "token")
                userdef.synchronize()
                print("pass")
            }
        }
    }
    
    func showAlert (message: String){
        
        let alert = UIAlertController(title: "خطاء", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "تم", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
