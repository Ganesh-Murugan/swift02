//
//  ViewController.swift
//  CollectionViewPractice
//
//  Created by zoho on 21/06/22.
//

import UIKit

class ViewController: UIViewController {
    private var calculator = CalculatorCells()
    private var values: [Calculator] { calculator.values }
    
    private var layout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 13.5, bottom: 0, right: 13.5)
        layout.minimumLineSpacing = 0.2
        layout.headerReferenceSize = CGSize(width: 420, height: 380)
        return layout
    }()
    private var resultView: UILabel = {
        var resultView = UILabel(frame: CGRect(x: 10, y: 200, width: 420, height: 50))
        resultView.backgroundColor = .opaqueSeparator
        resultView.textColor = .black
        
        return resultView
    }()
    private var textFeild: UITextView = {
        var textView = UITextView()
        textView.textAlignment = .right
        textView.frame = CGRect(x: 10, y: 50, width: 400, height: 300)
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 30)
        textView.textContainer.size = CGSize(width: 420, height: 50)
        textView.textContainer.maximumNumberOfLines = 1
        textView.layer.borderWidth = 0.2
        textView.layer.borderColor = UIColor.brown.cgColor
        return textView
    }()
    
    private var calculatorView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private func setupCalculatorView() {
        view.addSubview(calculatorView)
        calculatorView.addSubview(textFeild)
        textFeild.addSubview(resultView)
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
        return values.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.calculatorCollectionViewCellIdentifier, for: indexPath) as! CalculatorCollectionViewCell
       cell.addLabel(values, indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let type = values[indexPath.item].type
        textFeild.text += values[indexPath.item].value
        switch type {
        case .numeric:
            print(textFeild.text.filterNum())
        case .Operations(let operation):
            if !textFeild.text.isEmpty {
                resultView.text = textFeild.text
                calculationDecision(operation, textFeild.text)
            }
        }
    }
    private func calculationDecision(_ operation: Operators, _ prevValue: String) {
        
        print(prevValue.filterNum())
        var nextValue = "" { didSet { nextValue = nextValue.filterNum() } }
        
        switch operation {
        case .clear:
            textFeild.text = ""
        case .equal:
            print("g")
        default:
            performCalculation(operation)
        }
    }
    private func performCalculation(_ operation: Operators){
        
        switch operation {
        case .addition:
            print("")
        default:
            break
        }
    }
}
