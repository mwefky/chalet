    //
    //  RegisterViewController.swift
    //  astrahat
    //
    //  Created by on on 8/8/18.
    //  Copyright © 2018 on. All rights reserved.
    //
    
    import UIKit
    import SkyFloatingLabelTextField
    import DropDown
    import ObjectMapper
    
    class RegisterViewController: UIViewController,UITextFieldDelegate {
        
        
        enum type: String {
            case country = "country"
            case district = "district"
            case phone = "phone"
        }
        
        var moveView = false
        
        @IBOutlet weak var const_ViewMessage_Bottom: NSLayoutConstraint!
        @IBOutlet weak var regBtn: UIButton!
        @IBOutlet weak var chosenCountryCodeLbale: UILabel!
        @IBOutlet weak var countryCodeDropDownView: UIView!
        @IBOutlet weak var chosenCountryLabel: UILabel!
        @IBOutlet weak var countryDropDownView: UIView!
        @IBOutlet weak var agreeBtn: UIButton!
        
        @IBOutlet weak var confPassTF: UITextField!
        @IBOutlet weak var passwordTF: UITextField!
        @IBOutlet weak var phoneTF: UITextField!
        @IBOutlet weak var nameTf: UITextField!
        @IBOutlet weak var chosenDistrictLabel: UILabel!
        @IBOutlet weak var districtDropDownView: UIView!
        
        var countryDropDown : DropDown!
        var districtDropDown : DropDown!
        var phonePickerDropDown : DropDown!
        var agreed = false
        var countries = [[String: countryData]]()
        var distictts = [[String: DistrictData]]()
        
        var selectedCountryIndex = 0
        var selctedDistrictIndex = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            countryDropDown = DropDown()
            districtDropDown = DropDown()
            phonePickerDropDown = DropDown()
            countryDropDown.anchorView = countryDropDownView
            districtDropDown.anchorView = districtDropDownView
            phonePickerDropDown.anchorView = countryCodeDropDownView
            regBtn.layer.cornerRadius = regBtn.frame.size.height/2
            regBtn.clipsToBounds = true
            let CountryTap = UITapGestureRecognizer(target: self, action: #selector(self.handleCountryTap(_:)))
            countryDropDownView.addGestureRecognizer(CountryTap)
            let districtTap = UITapGestureRecognizer(target: self, action: #selector(self.handleDistrictyTap(_:)))
            districtDropDownView.addGestureRecognizer(districtTap)
            let phoneTap = UITapGestureRecognizer(target: self, action: #selector(self.handlephoneTap(_:)))
            countryCodeDropDownView.addGestureRecognizer(phoneTap)
            countryDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.chosenCountryLabel.text = item
                self.selectedCountryIndex = index
                print("Selected item: \(item) at index: \(index)")
            }
            districtDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.chosenDistrictLabel.text = item
                self.selctedDistrictIndex = index
                print("Selected item: \(item) at index: \(index)")
            }
            phonePickerDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.chosenCountryCodeLbale.text = item
                print("Selected item: \(item) at index: \(index)")
            }
            
            getIntialDropDown(type: type.country)
            getIntialDropDown(type: type.district)
            setUpTextFeild(textFeild: nameTf, imageName: "user_name")
            setUpTextFeild(textFeild: phoneTF, imageName: "phone_number")
            setUpTextFeild(textFeild: passwordTF, imageName: "password")
            setUpTextFeild(textFeild: confPassTF, imageName: "password")
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            //        keyboardSettings()
        }
        
        func keyboardSettings(){
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
            self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
            let swipeDown = UISwipeGestureRecognizer(target: self.view , action : #selector(UIView.endEditing(_:)))
            swipeDown.direction = .down
            self.view.addGestureRecognizer(swipeDown)
        }
        
        @objc func handleCountryTap(_ sender: UITapGestureRecognizer) {
            countryDropDown.show()
        }
        @objc func handleDistrictyTap(_ sender: UITapGestureRecognizer) {
            districtDropDown.show()
        }
        
        @objc func handlephoneTap(_ sender: UITapGestureRecognizer) {
            phonePickerDropDown.show()
        }
        @IBAction func agreeBtnTapped(_ sender: Any) {
            if !self.agreed{
                self.agreeBtn.setImage(UIImage(named: "accept"), for: .normal)
            }else {
                self.agreeBtn.setImage(UIImage(named: "confirm"), for: .normal)
            }
            self.agreed = !self.agreed
        }
        
        func getIntialDropDown(type : type) {
            
            let manger = ServerManager()
            var servicename : ServiceName!
            if type == .country {
                servicename = .countries
            }else if type == .district{
                servicename = .district
            }
            manger.perform(methodType: .get, needToken: false, serviceName: servicename, parameters: nil){
                (JSON, String) -> Void in
                
                if String != nil {
                    print("error")
                }else {
                    let response = JSON as! NSDictionary
                    if type == .country {
                        let countries = Mapper<countryData>().mapArray(JSONObject: response["data"] as Any)
                        for i in countries! {
                            
                            self.countryDropDown.dataSource.append(i.nameAr!)
                            self.countries.append([i.nameAr!: i])
                            self.phonePickerDropDown.dataSource.append(i.code!)
                        }
                        print(countries ?? "error")
                    } else if type == .district {
                        
                        var districts = Mapper<DistrictData>().mapArray(JSONObject: response["data"] as Any)
                        
                        for i in districts! {
                            self.distictts.append([i.nameAr!: i])
                            self.districtDropDown.dataSource.append(i.nameAr!)
                        }
                    }
                }
            }
        }
        
        
        
        @IBAction func regBtnTapped(_ sender: Any) {
            
            if passwordTF.text != confPassTF.text {
                
                showAlert(message: "كلمه المرور غير متطابقه")
                return
            }
            
            
            var countryID = -1000
            var citiID = -1000
            for i in countries {
                
                if i.first?.key == chosenCountryLabel.text {
                    countryID = (i.first?.value.id!)!
                }
            }
            for i in distictts {
                
                if i.first?.key == chosenDistrictLabel.text {
                    
                    citiID = (i.first?.value.id!)!
                }
            }
            
            if phoneTF.text == "" || nameTf.text == "" || passwordTF.text == "" || countryID == -1000 || citiID == -1000 || chosenCountryCodeLbale.text == "+00" {
                showAlert(message: "برجاء ملاء جميع الحقول")
                return
            }
            if !agreed {
                showAlert(message: "برجاء الموافقه علي شروط الاستخدام")
                return
                
            }
            let manger = ServerManager()
            let params = ["name" : nameTf.text!,
                          "password": passwordTF.text!,
                          "phone": chosenCountryCodeLbale.text! + phoneTF.text!,
                          "firebase": "firebase token",
                          "country_id":countryID,
                          "city_id" : citiID,
                          "role_id" : "1"] as [String : AnyObject]
            manger.perform(methodType: .post, needToken: false, serviceName: .register, parameters: params){
                (JSON, String) -> Void in
                if String != nil {
                    self.showAlert(message: String!)
                } else {
                    
                    print("pass")
                }
            }
        }
        
        func showAlert (message: String){
            
            let alert = UIAlertController(title: "خطاء", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "تم", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        func setUpTextFeild(textFeild :UITextField , imageName: String){
            
            textFeild.leftViewMode = .always
            let imageView = UIImageView()
            imageView.frame = CGRect(x: 5, y: 10, width: 20, height: 20);
            let image = UIImage(named: imageName);
            imageView.image = image;
            textFeild.addSubview(imageView)
            
        }
        
        
        @objc func keyboardWillShow(notification: NSNotification) {
            if moveView {
                if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                    if self.view.frame.origin.y == 0{
                        self.view.frame.origin.y -= keyboardSize.height - 10
                    }
                }
            }
        }
        
        @objc func keyboardWillHide(notification: NSNotification) {
            if moveView {
                if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                    if self.view.frame.origin.y != 0{
                        self.view.frame.origin.y += keyboardSize.height - 10
                    }
                }
            }
        }
        
        @objc func keyboardNotification(notification: NSNotification) {
            
            if let userInfo = notification.userInfo {
                if let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
                    if let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue{
                        
                        let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
                        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
                        let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
                        
                        if (endFrame.origin.y) >= UIScreen.main.bounds.size.height {
                            self.const_ViewMessage_Bottom?.constant = 0.0
                        } else {
                            self.const_ViewMessage_Bottom?.constant = endFrame.size.height
                        }
                        
                        UIView.animate(withDuration: duration,
                                       delay: TimeInterval(0),
                                       options: animationCurve,
                                       animations: { self.view.layoutIfNeeded() },
                                       completion: nil)
                    }
                }
            }
        }
        
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            if textField == self.nameTf || textField == self.phoneTF{
                moveView = false
            }else {
                moveView = true
            }
            return true
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true;
        }
    }
