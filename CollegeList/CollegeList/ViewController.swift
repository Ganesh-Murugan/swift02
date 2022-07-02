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
    var dataSource = CountryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(countryTableView)
        countryTableView.delegate = self
        countryTableView.dataSource = dataSource
        countryTableView.register(CountryTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.countryCellIdentifier)
        dataSource.fetchCountryData()
        
        self.dataSource.reloadTable = { [weak self] in
                self?.countryTableView.reloadData()
            
        }
    }
    override func viewDidLayoutSubviews() {
        countryTableView.frame = CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: view.frame.size.width, height: view.frame.size.height)
        
    }
}

extension ViewController: UITableViewDelegate {
    
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        1
    //    }
    //
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        UITableViewCell()
    //    }
    
    
}
