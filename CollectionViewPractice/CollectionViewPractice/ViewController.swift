//
//  ViewController.swift
//  CollectionViewPractice
//
//  Created by zoho on 21/06/22.
//

import UIKit

class ViewController: UIViewController {
    var numbers = Calculator().numbers.toString
    
    
    var layout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 0.5
        layout.headerReferenceSize = CGSize(width: 420, height: 400)
        return layout
    }()
    
    var calculatorView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private func setupCalculatorView() {
        view.addSubview(calculatorView)
        calculatorView.dataSource = self
        calculatorView.delegate = self
        calculatorView.backgroundColor = .white
        calculatorView.collectionViewLayout = layout
        calculatorView.register(CalculatorCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.calculatorCollectionViewCellIdentifier)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalculatorView()
    }
    override func viewDidLayoutSubviews() {
        calculatorView.frame = CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: view.frame.size.width, height: view.frame.size.height)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.calculatorCollectionViewCellIdentifier, for: indexPath) as! CalculatorCollectionViewCell
        cell.cellValue.setTitle(numbers[indexPath.row], for: .normal)
        return cell
    }
    
}
