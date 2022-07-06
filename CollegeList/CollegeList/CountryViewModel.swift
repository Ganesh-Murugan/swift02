////
////  CountryViewModel.swift
////  CollegeList
////
////  Created by zoho on 02/07/22.
////

//
//import Foundation
//import UIKit
//
//class CountryViewModel:NSObject {
//    
//    override init() {}
//    
//    
//    var selectedCounty = ""
//    
//    var country: [Countries] = []
//    var colleges: [College] = []
//    
//    var reloadTable: (() -> Void)?
//    
//    func fetchCountryData() {
//        let url = Constants.Urls.countriesUrl
//            URLSession.shared.request(for: url, expecting: Response.self) { [weak self] result in
//                switch result {
//                case .success(let responseData):
//                    guard let values = responseData.data?.values else { return }
//                        self?.data = Array(values)
//                        self?.reloadTable?()
//                case .failure(let error): print(error.localizedDescription)
//                }
//            }
//    }
//    
//    func fetchquery(_ indexPathRow: Int, completion: @escaping (()->Void)) {
//        var url = Constants.Urls.collegesUrl
//        guard let countries = data as? [Countries], countries.count > 0 else {
//            return
//        }
//        let country = countries[indexPathRow].country.unwrap.replacingOccurrences(of: " ", with: "%20")
//        url += "?country=\(country)"
//        print(url)
//            URLSession.shared.request(for: url, expecting: [College].self) { [weak self] result in
//                switch result {
//                case .success(let responseData):
//                    completion()
//                    let values = responseData
//                        self?.data = values
////                        self?.reloadTable?()
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
//
//extension CountryViewModel: UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.countryCellIdentifier, for: indexPath) as! CountryTableViewCell
//        cell.add(data[indexPath.row])
//        return cell
//    }
//}
//
//
////enum Direction {
////    case east,west,north,south
////}
////
////
////class one {
////    func demo(closure: ((Int)->Void)) {
////        print("CALLED")
////    }
////    
////    func test(comp: @escaping((Direction) -> Void)) {
////        
////    }
////    
////    func closureCheck(dirc: ((Direction) -> Void), value: String) {
////        
////        if value == "12345" {
////            print(value)
////            dirc(.east)
////        } else {
////            print(value)
////            dirc(.west)
////        }
////    }
////}
////
////class two: one {
////    var n = one()
////    var model: ((Direction) -> Void)?
////    var modelTwo: ((Int)->Void)?
////    var no: Int = 0
////    func demoTwo() {
////        closureCheck(dirc: { (dirc) in
////            if dirc == .east {
////                print("Correct number")
////            } else if dirc == .west {
////                print("Wrong number")
////            }
////        }, value: "12345")
////    }
////    
////    override func demo(closure: ((Int)->Void)) {
//////        self.modelTwo = closure
////        self.model?(.east)
////        closure(5)
////    }
////    
////    override func test(comp: @escaping ((Direction) -> Void)) {
////        self.model = comp
////    }
////    
////    func m(m: Int) {
////        no = m
////    }
////    
////}
