//
//  ViewController.swift
//  boundstest
//
//  Created by zoho on 20/06/22.
//

import UIKit

class ViewController: UIViewController {

    
    var subView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 250, y: 400, width: 100, height: 100)
        view.backgroundColor = .blue
        return view
    }()
    private func checkBounds() {
        view.addSubview(subView)
        let testView = UIView(frame: CGRect(x: subView.frame.origin.x,
                                            y: subView.frame.origin.y,
                                            width: subView.frame.size.width,
                                            height: subView.frame.size.height))
        testView.layer.borderColor = UIColor.green.cgColor
        testView.layer.borderWidth = 2
        
       
        subView.transform = CGAffineTransform(rotationAngle: 10)
        view.addSubview(testView)
        print(subView.bounds)
        print(subView.frame)
        print(subView.bounds)
        print(subView.frame)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        checkBounds()
        // Do any additional setup after loading the view.
    }


}

