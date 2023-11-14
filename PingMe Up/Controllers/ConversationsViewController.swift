//
//  ViewController.swift
//  PingMe Up
//
//  Created by anshul on 14/11/23.
//

import UIKit
//import FirebaseAuth
class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "Logged_in")
        
        if !isLoggedIn{
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
        
        
        }
        
        
    }




