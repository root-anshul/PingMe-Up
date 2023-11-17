//
//  ViewController.swift
//  PingMe Up
//
//  Created by anshul on 14/11/23.
//

import UIKit
import FirebaseAuth
import Firebase
class ConversationsViewController: UIViewController {
    
//    private let tableview: UITableView = {
//        let table = UITableView()
//        return table
//    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
        validateAuth()
          
        }
        
    private func validateAuth(){
        if FirebaseAuth.Auth.auth().currentUser==nil{
            let vc=LoginViewController()
            let nav=UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav,animated: false)
        }
    }
    }




