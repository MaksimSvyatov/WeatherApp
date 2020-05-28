//
//  SearchViewController.swift
//  WheatherApp
//
//  Created by Admin on 28.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    let searchCity: SearchServiceProtocol = NetworkManagerViewController()
    let urlString = "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=8377ec5a9d2db6e91c9d69e92c0473ac"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        searchCity.searchCity(urlString: urlString) { (result) in
            switch result {
                
            case .success(let searchResponse):
                print(searchResponse.name, searchResponse.main?.temp)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    private func setupSearchBar() {
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Test cell"
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
}
