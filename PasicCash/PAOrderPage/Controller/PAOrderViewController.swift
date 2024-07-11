//
//  PAOrderViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/2.
//

import UIKit

class PAOrderViewController: PABaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .random()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PATabBarManager.showTabBar()
    }

    

}
