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
    let networkDataFetcher = NetworkDataFetcher()
    let searchingCityDataFetcher = NetworkDataFetcher()
    var currentWeatherConditionsInSearchingCity: WeatherDescriptionInSearchingCityContainer?
    var weatherInConcreteCity: WeatherInformation? = nil
    var selectedItem: WeatherInformation?
    var selectedItem1: WeatherDescriptionInSearchingCityContainer?
    var cityCount = [String]()
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchBar()
        setupTableView()
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
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = weatherInConcreteCity
        selectedItem1 = currentWeatherConditionsInSearchingCity
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? DetailedViewController else { return }
        guard let selectedItem = selectedItem else { return }
        destinationVC.data = selectedItem
        destinationVC.data1 = selectedItem1
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        guard let tempInDouble = weatherInConcreteCity?.main?.temp else { return cell }
        let tempInInt = Int(tempInDouble - 273.15)
        let tempInString = String(tempInInt)
        cell.textLabel?.text = weatherInConcreteCity?.name
        cell.detailTextLabel?.text = tempInString
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(searchText)&appid=8377ec5a9d2db6e91c9d69e92c0473ac"
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchCities(urlString: urlString) { (searchResponse) in
                guard let searchResponse = searchResponse else { return }
                self.weatherInConcreteCity = searchResponse
                guard let cityName = searchResponse.name else { return }
                self.cityCount.append(cityName)
                self.tableView.reloadData()
            }
            
            self.searchingCityDataFetcher.fetchSearchingCityConditions (urlString: urlString) { (searchingResponse) in
                guard let searchingResponse = searchingResponse else { return }
                self.currentWeatherConditionsInSearchingCity = searchingResponse
            }
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        cityCount = []
        tableView.reloadData()
    }
}
