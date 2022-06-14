//
//  ViewController.swift
//  Practice
//
//  Created by zoho on 10/06/22.
//

import UIKit

class ViewController: UIViewController {
    let searchController = UISearchController()
    var searching = false
    var searchResult = [Contacts]()
    @IBOutlet weak var contactTable: UITableView!
//    override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//        view.backgroundColor = UIColor.red
//            print("viewWillAppear(_:) called")
//        }
//
//        override func viewDidAppear(_ animated: Bool) {
//            super.viewDidAppear(animated)
//            view.backgroundColor = UIColor.yellow
//            print("viewDidAppear(_:) called")
//        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        searchController.loadViewIfNeeded()
        searchController.searchBar.placeholder = "Search.."
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        contactTable.delegate = self
        contactTable.dataSource = self
        sectionTitle.forEach({contactDict[String($0)] = [Contacts]()})
        contactList.forEach({contactDict[String($0.name.unwrap.prefix(1))]?.append($0)})
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return !searching ? sectionTitle.count : 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return !searching ? sectionTitle[section] : "Search Result"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !searching ? contactDict[sectionTitle[section]]?.count ?? 0 : searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactTable.dequeueReusableCell(withIdentifier: "newIdentifier", for: indexPath) as! ContactCell
        let list = !searching ? contactDict[sectionTitle[indexPath.section]]! : searchResult
        
        cell.name?.text = list[indexPath.row].name
        cell.number?.text = list[indexPath.row].number?.toString
        cell.emailId?.text = list[indexPath.row].emailId
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected one of the cell, \(indexPath)")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        if !text.isEmpty {
            searching = true
            searchResult = contactList.searchFilter(searchText: text)
        } else {
            searching = false
            searchResult.removeAll()
            searchResult = contactList
        }
        contactTable.reloadData()
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
//            contactTable.beginUpdates()
           // contactList.remove(at: indexPath.row)
//            contactDict.remove(at: )
            var removed = contactDict[sectionTitle[indexPath.section]]
           // removed?[indexPath.row]
            let removeItem = removed?.remove(at: indexPath.row)
            contactDict[sectionTitle[indexPath.section]] = removeItem
            //1
            contactTable.deleteRows(at: [indexPath], with: .automatic)
//            contactTable.reloadData()
//            contactTable.endUpdates()
        }
        
    }
}


