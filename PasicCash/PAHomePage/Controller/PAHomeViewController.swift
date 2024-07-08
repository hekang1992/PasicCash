//
//  PAHomeViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/2.
//

import UIKit

class PAHomeViewController: PABaseViewController {
    
    lazy var oneView: PABigCardView = {
        let oneView = PABigCardView()
        return oneView
    }()
    
    lazy var twoView: PAProductView = {
        let twoView = PAProductView()
        return twoView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        homeDataApi()
        
    }
}

extension PAHomeViewController {
    
    func homeDataApi() {
        ViewHud.addLoadView()
        PARequestManager.shared.requestAPI(params: [:], pageUrl: home_api, method: .get) { baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                
            }
            ViewHud.hideLoadView()
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }

}
