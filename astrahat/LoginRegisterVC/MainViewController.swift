//
//  MainViewController.swift
//  astrahat
//
//  Created by on on 8/8/18.
//  Copyright © 2018 on. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var registerbtn: UIButton!
    @IBOutlet weak var loginbtn: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    private lazy var rgisteViewController: RegisterViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "registerViewController") as! RegisterViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var loginViewController: LoginViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "logiViewController") as! LoginViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.backgroundColor = UIColor(red: 93/255.0, green: 188/255.0, blue: 210/255.0, alpha: 1.0)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        add(asChildViewController: loginViewController)
        remove(asChildViewController: rgisteViewController)
    }
    
    
    @IBAction func registerBtntapped(_ sender: Any) {
        remove(asChildViewController: loginViewController)
        add(asChildViewController: rgisteViewController)
        
    }
    
    @IBAction func loginbtnTapped(_ sender: Any) {
        
        add(asChildViewController: loginViewController)
        remove(asChildViewController: rgisteViewController)
    }
    
    
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
    
}

