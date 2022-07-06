//
//  ViewController.swift
//  CollegeList
//
//  Created by zoho on 02/07/22.
//

import UIKit
//nw_protocol_get_quic_image_block_invoke dlopen libquic failed

class ViewController: UIViewController {
    
    let countryTableView = UITableView()
    var apiHandler = APIHandler()
    var countriesList = [Countries]()
    
    
    
    private func setupView(){
        view.addSubview(countryTableView)
        view.backgroundColor = .white
        countryTableView.rowHeight = UITableView.automaticDimension
        countryTableView.estimatedRowHeight = 100
        countryTableView.delegate = self
        countryTableView.dataSource = self
        countryTableView.register(CountryTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.countryCellIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        apiHandler.fetchCountryData() { [weak self] countries in
            guard let countries = countries?.values else {
                return
            }
            self?.countriesList = Array(countries)
            DispatchQueue.main.async {
                self?.countryTableView.reloadData()
            }
        }
    }
    override func viewDidLayoutSubviews() {
        countryTableView.frame = view.bounds
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.countryCellIdentifier, for: indexPath) as! CountryTableViewCell
        cell.add(countriesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let vc = CollegeViewController()
        //        vc.index = indexPath.row
        //        vc.data = dataSource.data
        //        self.navigationController?.pushViewController(vc, animated: true)
        
        //        let vc = ViewController()
        //        vc.title = "Colleges"
        //        self.navigationController?.pushViewController(vc, animated: true)
        //        vc.dataSource.fetchquery(indexPath.row) {
        //            DispatchQueue.main.async {
        //                vc.countryTableView.reloadData()
        //            }
        //        }
    }
}
