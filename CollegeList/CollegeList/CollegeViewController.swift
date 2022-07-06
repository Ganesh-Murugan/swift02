////
////  CollegeViewController.swift
////  CollegeList
////
////  Created by zoho on 06/07/22.
////
//
//import UIKit
//
//class CollegeViewController: UIViewController {
//    var index: Int = 0
//    let collegeTableView = UITableView()
//    var data: [Data] = []
//    var colleges: [College] = [] 
//
//    
//    private func fetchquery(_ indexPathRow: Int) {
//        var url = Constants.Urls.collegesUrl
//        guard let countries = data as? [Countries] else {
//            return
//        }
//        var country = countries[indexPathRow].country.unwrap.replacingOccurrences(of: " ", with: "%20")
//        country.customTrim()
//        url += "?country=\(country)"
//        print(url)
//            URLSession.shared.request(for: url, expecting: [College].self) { [weak self] result in
//                switch result {
//                case .success(let responseData):
//                    let values = responseData
//                        self?.colleges = values
//                    DispatchQueue.main.async {
//                        self?.collegeTableView.reloadData()
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    
//    private func setupView(){
//        view.addSubview(collegeTableView)
//        title = "Colleges"
//        view.backgroundColor = .white
//        collegeTableView.delegate = self
//        collegeTableView.dataSource = self
//        collegeTableView.register(CountryTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.countryCellIdentifier)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        fetchquery(index)
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        collegeTableView.frame = view.bounds
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//    }
//}
//
//extension CollegeViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        colleges.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.countryCellIdentifier, for: indexPath) as! CountryTableViewCell
//        cell.add(colleges[indexPath.row])
//        return cell
//    }
//    
//    
//}
