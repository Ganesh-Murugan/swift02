//
//  ViewController.swift
//  SettingsScreen
//
//  Created by zoho on 16/06/22.
//

import UIKit

class ViewController: UIViewController {
    let settingView = UITableView()
    func setupTableView(){
//        let settingView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .plain)
        settingView.delegate = self
        settingView.dataSource = self
        settingView.rowHeight = 80
        settingView.estimatedRowHeight = 100
        settingView.register(SwitchCell.self, forCellReuseIdentifier: "switchcell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        settingView.frame = view.bounds
        setupTableView()
        view.addSubview(settingView)
        
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "switchcell", for: indexPath) as! SwitchCell
        cell.addCell(settings[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
