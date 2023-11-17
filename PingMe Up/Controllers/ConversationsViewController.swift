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
    
    private let tableview: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let noConversationsLabel: UILabel = {
        let label = UILabel()
        label.text = "No Conversations!"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.isHidden = true
        return label
    }()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                                    target: self,
                                                            action: #selector(didtapcomposeButton))
        view.addSubview(tableview)
        view.addSubview(noConversationsLabel)
        setuptableView()
        fetchConversations()
    }
                                                            
    @objc private func didtapcomposeButton(){
            let vc = NewConversationViewController()
           let navVc = UINavigationController(rootViewController: vc)
        present(navVc, animated: true)
        }
                                                            
                                                
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews ()
        tableview.frame = view.bounds
    }


    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
        validateAuth()
        setuptableView()
        }
    private func setuptableView(){
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    
    private func validateAuth(){
        if FirebaseAuth.Auth.auth().currentUser==nil{
            let vc=LoginViewController()
            let nav=UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav,animated: false)
        }
    }
    private func fetchConversations(){
        tableview.isHidden = false
    }
    
    }
extension ConversationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello World"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = ChatViewController()
        vc.title = "Jenny Smith"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}


