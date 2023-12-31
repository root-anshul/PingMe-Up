//
//  NewConversationViewController.swift
//  PingMe Up
//
//  Created by anshul on 14/11/23.
//

import UIKit

class NewConversationViewController: UIViewController {

    private var searchar:UISearchBar={
    let searchBar = UISearchBar()
        searchBar.placeholder = "Search for Users..."
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self,
        forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let noResultsLabel: UILabel={
    let label = UILabel()
    label.isHidden = true
    label.text = "No Results"
    label.textAlignment = .center
    label.textColor = .green
    label.font = .systemFont(ofSize: 21, weight: .medium)
    return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.titleView = searchar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .done, target: self, action: #selector(dismissSelf))
        searchar.becomeFirstResponder()
    }
    
    @objc private func dismissSelf() {
        dismiss(animated:true, completion: nil)
    }
}

extension NewConversationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    }
    
}
