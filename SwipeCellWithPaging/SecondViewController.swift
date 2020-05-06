//
//  SecondViewController.swift
//  SwipeCellWithPaging
//
//  Created by master on 2020/04/27.
//  Copyright © 2020 ksb. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeRecognizer.direction = .right
        self.view.addGestureRecognizer(swipeRecognizer)
    }
    
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            self.tabBarController?.selectedIndex = 0
        }
    }


}

