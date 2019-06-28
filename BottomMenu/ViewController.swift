//
//  ViewController.swift
//  BottomMenu
//
//  Created by Trung Phan on 6/28/19.
//  Copyright © 2019 Dwarvesf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bottomView = Bundle.main.loadNibNamed("BottomMenuView", owner: self, options: nil)?.first as! BottomMenuView
        view.addSubview(bottomView)
        bottomView.screenHeight = UIScreen.main.bounds.height
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        view.layoutIfNeeded()
    }

}

