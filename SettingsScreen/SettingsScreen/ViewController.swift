//
//  ViewController.swift
//  SettingsScreen
//
//  Created by zoho on 16/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    func setupTableView() -> UITableView{
        let settingView = UITableView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height), style: .plain)
        settingView.delegate = self
        settingView.dataSource = self
        return settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(setupTableView())
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    
}
