//
//  PALoginViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/4.
//

import UIKit

class PALoginViewController: PABaseViewController {
    
    lazy var loginView: PALoginView = {
        let loginView = PALoginView()
        return loginView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loginView.block = { [weak self] in
            let codeVc = PACodeViewController()
            self?.navigationController?.pushViewController(codeVc, animated: true)
        }
        loginView.block1 = {
            NotificationCenter.default.post(name: Notification.Name(ROOT_VC), object: nil, userInfo: ["login": "1"])
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension PALoginViewController {
    
    
}
