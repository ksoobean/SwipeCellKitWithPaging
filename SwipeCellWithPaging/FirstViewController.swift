//
//  FirstViewController.swift
//  SwipeCellWithPaging
//
//  Created by master on 2020/04/27.
//  Copyright © 2020 ksb. All rights reserved.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
    private var list : ListView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if nil == list {
            list = ListView.instance()
            self.view.addSubview(list!)
            
            list?.snp.removeConstraints()
            list?.snp.makeConstraints({ (make) in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
            })
            
        }
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeRecognizer.direction = .left
        self.view.addGestureRecognizer(swipeRecognizer)
    }
    
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            self.tabBarController?.selectedIndex = 1
        }
    }
    
}

