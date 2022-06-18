//
//  ViewController.swift
//  SettingsScreen
//
//  Created by zoho on 16/06/22.
//

import UIKit
public enum State : Int {
   case active
   case inactive
   case background
}
class ViewController: UIViewController {
    
    var content = settings
    let settingView = UITableView()
    var header = "Settings"
    
    private func setupTableView() {
        
        settingView.tableFooterView = UIView()
        settingView.frame = view.bounds
        settingView.delegate = self
        settingView.dataSource = self
        
        settingView.register(SwitchCell.self, forCellReuseIdentifier: "switchcell")
        settingView.register(IconCell.self, forCellReuseIdentifier: "iconcell")
        settingView.register(SliderCell.self, forCellReuseIdentifier: "slidercell")
        settingView.register(DescriptiveCell.self, forCellReuseIdentifier: "descriptiveCell")
        
    }
    
    @objc func doSomething() {
        print("pause activities")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        let notificationCenter = NotificationCenter.default
//            notificationCenter.addObserver(self, selector: #selector(doSomething), name: UIApplication.didEnterBackgroundNotification, object: nil)
        print("viewDidLoad")
        setupTableView()
        settingView.clipsToBounds = true
        view.addSubview(settingView)
        self.title = header
        
    }
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
    }
    override func viewWillLayoutSubviews() {
        print("viewWillLayoutSubviews")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        content.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = settings[indexPath.row].settingType
        switch type {
        case .toggle(_):
            return 90
        case .navigate:
            return 80
        case .slider:
            return 180
        case .about:
            return 80
        }
    }
    
    func addCell(tableView: UITableView, indexPath: IndexPath, id: String) -> Cell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! Cell
        cell.addCell(content[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = content[indexPath.row].settingType
        
        switch type {
        case .navigate(_):
            return addCell(tableView: tableView, indexPath: indexPath, id: "iconcell") as! IconCell
        case .toggle(let toggled):
            let cell = addCell(tableView: tableView, indexPath: indexPath, id: "switchcell") as! SwitchCell
            cell.toggle.setOn(toggled, animated: true)
            return cell
        case .slider(let value):
            let cell = addCell(tableView: tableView, indexPath: indexPath, id: "sliderCell") as! SliderCell
            cell.slider.setValue(value, animated: true)
            return cell
        case .about:
            return addCell(tableView: tableView, indexPath: indexPath, id: "descriptiveCell") as! DescriptiveCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var type = content[indexPath.row].settingType
        switch type {
        case .toggle(_):
            if let cell = settingView.cellForRow(at: indexPath) as? SwitchCell {
                type = .toggle(!cell.toggle.isOn)
                cell.toggled()
            }
            print(type)
        case .slider(_):
            if let cell = settingView.cellForRow(at: indexPath) as? SliderCell {
                type = .slider(cell.slider.value)
            }
            print(type)
        case .about:
            print(indexPath)
            
        case .navigate(let navigateTo):
            let viewController = ViewController()
            switch navigateTo {
            case .displaySettings:
                viewController.content = displaySettings
                viewController.header = "Display Settings"
                self.navigationController?.pushViewController(viewController, animated: true)
            case .about:
                viewController.content = about
                viewController.title = "About"
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
