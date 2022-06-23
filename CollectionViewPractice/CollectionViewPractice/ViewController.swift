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
    private var prevValue = "0"
    { didSet { prevValue = prevValue.removeEqual() } }
    var nextValue = Int()
    var newValue = Int()
    var prevOperator = String()
    
    private var cellViewlayout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
//        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 13.5, bottom: 0, right: 13.5)
        layout.minimumLineSpacing = 0.2
        layout.headerReferenceSize = CGSize(width: 420, height: 340)
        return layout
    }()
    private var resultView: UILabel = {
        var resultView = UILabel(frame: CGRect(x: 10, y: 200, width: 380, height: 100))
        resultView.backgroundColor = .opaqueSeparator
        resultView.textColor = .black
        resultView.textAlignment = .right
        return resultView
    }()
    private var textFeild: UITextView = {
        var textView = UITextView()
        textView.textAlignment = .right
        textView.frame = CGRect(x: 10, y: 10, width: 400, height: 300)
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 30)
        textView.textContainer.size = CGSize(width: 420, height: 50)
        textView.textContainer.maximumNumberOfLines = 1
        textView.layer.borderWidth = 0.2
        textView.layer.borderColor = UIColor.brown.cgColor
        textView.isUserInteractionEnabled = false
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
        calculatorView.collectionViewLayout = cellViewlayout
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

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        indexPath.item == 17 ? CGSize(width: 300, height: 100) : CGSize(width: 100, height: 100)
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.calculatorCollectionViewCellIdentifier, for: indexPath) as! CalculatorCollectionViewCell
        cell.applyColor(values[indexPath.item])
        cell.addLabel(values, indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = values[indexPath.item].type
        textFeild.text += values[indexPath.item].value.removeEqual()
//        textFeild.text = textFeild.text.removeEqual()
//        prevValue += values[indexPath.item].value
//        switch type {
//        case .numeric:
//            resultView.text = textFeild.text
//        case .Operations(.clear):
//            prevValue = "0"
//            textFeild.text = ""
//            resultView.text = ""
//
//        case .Operations(.backSpace):
//            textFeild.text.backSpace(2)
//            prevValue.backSpace(2)
//            resultView.text?.backSpace(1)
//
//        case .Operations(.equal):
//            textFeild.text.removeLast()
//            checkValid(prevValue.suffix(1).toString)
//            let expression = NSExpression(format: prevValue)
//            if let value = expression.expressionValue(with: nil, context: nil) as? Double {
//                resultView.text = value.formatDecimal
//            }
//
//        case .Operations(let operation):
//            if textFeild.text.count > 1 {
//                prevValue.convertFloat(operation.rawValue)
//                checkValid(textFeild.text[textFeild.text.count - 2])
//            } else {
//                textFeild.text.removeLast()
//                prevValue.removeLast()
//            }
//        }
//    }
//    private func checkValid(_ value: String) {
//        if Operators.rawValues.contains(value) {
//            textFeild.text.removeLast()
//            prevValue.removeLast()
//        }
//    }
//}


//        print(prevValue)
        switch type {
        
        case .numeric:
            if nextValue != 0 {
                prevValue = nextValue.toString
            }
            prevValue += values[indexPath.item].value
        case .Operations(.clear):
            prevValue = "0"
            textFeild.text = ""
            resultView.text = ""
            newValue = 0
        case .Operations(.equal):
            if Operators.rawValues.contains(textFeild.text.suffix(1).toString){
                textFeild.text.removeLast()
            }
            resultView.text = newValue.toString
            calculation(prevOperator)

        case .Operations(let operation):
            nextValue = 0
            print("1",newValue, prevValue)
            if textFeild.text.count <= 1 {
                textFeild.text.removeLast()
            }
            prevOperator = operation.rawValue
            switch prevOperator {
            case "+":
                newValue += prevValue.toInt
            case "-":
                newValue = prevValue.toInt - newValue
            case "*":
                newValue = newValue == 0 ?  prevValue.toInt : newValue
            case "/":
                
                if prevValue.toInt != 0{
                    newValue = prevValue.toInt
//                    newValue = newValue / (Int(prevValue) ?? 1)
                }
            
            default:
                print("_")
            }
            print("2",newValue, prevValue)
            prevValue = "0"
        
        }
    }

    func calculation(_ operation: String) {
       print("3",newValue, prevValue)
        switch operation {
        case "+":
            newValue += prevValue.toInt
        case "-":
            newValue -= prevValue.toInt
        case "*":
            newValue *= prevValue.toInt
        case "/":
            if newValue != 0, prevValue.toInt != 0 {
                newValue /= prevValue.toInt
            } else { newValue = 0 }
            
        default :
            print("")
        }
        print("4",newValue, prevValue)
        nextValue = newValue
        prevValue = "0"
        resultView.text = newValue.toString
        prevOperator = ""
    }
}
