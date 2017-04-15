//
//  ViewController.swift
//  TinyCOnstraintsSample
//
//  Created by mitake on 2017/04/15.
//  Copyright © 2017 mitake. All rights reserved.
//

import UIKit
import TinyConstraints

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let subView = UIView()
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.backgroundColor = .green
        view.addSubview(subView)
        
        // view と同じ大きさにする
        // subView.edges(to: view)
        
        // view の中心と合わせる
        subView.center(in: view)
        
        // 幅指定
        subView.width(100)
        
        // 高さ指定
        subView.height(100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

