//
//  ListView.swift
//  SwipeCellKitSample
//
//  Created by master on 2020/04/24.
//  Copyright © 2020 ksb. All rights reserved.
//

import UIKit
import SwipeCellKit

class ListView: UIView {

    // CollectionView
    @IBOutlet weak var listCollectionView: UICollectionView!
    // Cell Id
    let cellId : String = "CollectionViewCell"
    // 데이터 리스트
    var dataArray : [String] = []
    
    //
    var isSwipeLeftEnabled = true
    
    //MARK:- 생성자
    public class func instance() -> ListView {
        let listView = Bundle.main.loadNibNamed("ListView", owner: self, options: nil)?.first as! ListView
        
        listView.loadView()
        
        return listView
    }
    //MARK:- 화면 구성
    private func loadView() {
        self.listCollectionView.register(UINib.init(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        self.listCollectionView.delegate = self
        self.listCollectionView.dataSource = self
        
        // dataArray 임의 데이터 넣어주기
        for i in 1..<6 {
            dataArray.append("\(i)")
            
        }
    }
}


extension ListView : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionViewCell
        
        cell.delegate = self        // SwipeCollectionViewCellDelegate 필수
        cell.configCell(text: dataArray[indexPath.row])
        
        return cell
    }
    
}

//MARK:- SwipeCell Delegate
extension ListView : SwipeCollectionViewCellDelegate {
    // protocol func
    /// 특정 방향으로 Cell을 Swipe 했을 때 나오는 액션들 구현
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - indexPath: indexPath
    ///   - orientation: Swipe 방향
    /// - Returns: Swipe Action Array
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        var actionList = [SwipeAction]()
        
        switch orientation {
        case .right :
            // 오른쪽에서 스와이프했을 때 나오는 액션
            // 삭제
            let deleteAction = SwipeAction(style: .destructive, title: "삭제") { (action, indexPath) in
                print("Swipe from right / Delete Action")
            }
            deleteAction.image = UIImage(named: "delete")
            
            // 더보기
            let moreAction = SwipeAction(style: .default, title: "더보기") { (action, indexPath) in
                print("Swipe from right / More Action")
            }
            moreAction.backgroundColor = .lightGray
            moreAction.image = UIImage(named: "more")
            actionList = [deleteAction, moreAction]
            
        case .left :
            // 왼쪽에서 스와이프했을 때 나오는 액션
            guard indexPath.section != 0 else { return nil }
            // 고정
            let setTopAction = SwipeAction(style: .default, title: "") { (action, indexPath) in
                print("Swipe from left / Set Top Action")
            }
            setTopAction.backgroundColor = .magenta
            setTopAction.image = UIImage(named: "setTop")
            
            // 즐겨찾기
            let favoriteAction = SwipeAction(style: .default, title: nil) { (action, indePath) in
                print("Swipe from left / Favorite Action")
            }
            favoriteAction.backgroundColor = .purple
            favoriteAction.image = UIImage(named: "favorite")
            
            actionList = [setTopAction, favoriteAction]
            
        default :
            print("wrong swipe action...")
            break
        }
        
        return actionList
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        
        if indexPath.section == 0 {
            options.expansionStyle = .none
            options.transitionStyle = .border
        } else if indexPath.section == 1 {
            if orientation == .right {
                options.expansionStyle = .destructive
                options.transitionStyle = .drag
            } else {
                options.expansionStyle = .selection
                options.transitionStyle = .reveal
            }
        }
        
        
        return options
    }
    
}
