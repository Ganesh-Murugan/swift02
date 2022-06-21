//
//  ViewController.swift
//  AppScreen
//
//  Created by zoho on 21/06/22.
//

import UIKit

class AppScreenViewController: UIViewController {
    var apps = Apps().apps
    var appScreenCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
   
    var layout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 35
        layout.minimumInteritemSpacing = 25
        layout.sectionInset = UIEdgeInsets(top: 1, left: 20, bottom: 1, right: 20)
        layout.itemSize = CGSize(width: 70, height: 70)
        
        return layout
    }()
    private func setupAppScreenView(){
        appScreenCollectionView.delegate = self
        appScreenCollectionView.dataSource = self
        appScreenCollectionView.collectionViewLayout = layout
        appScreenCollectionView.backgroundColor = .white
        appScreenCollectionView.showsHorizontalScrollIndicator = false
        appScreenCollectionView.isPagingEnabled = true
        appScreenCollectionView.register(AppIconCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.appIconCollectionViewCell)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        appScreenCollectionView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 120, width: view.frame.size.width, height: view.frame.size.height - 400)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppScreenView()
        view.addSubview(appScreenCollectionView)
    }
}

extension AppScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(apps.count/20)
        return apps.count/20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.appIconCollectionViewCell, for: indexPath) as! AppIconCollectionViewCell
        cell.iconLabel.text = apps[indexPath.row].appName
        return cell
    }
    
    
}
