//
//  PALoginViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/4.
//

import UIKit
import MBProgressHUD_WJExtension

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
            self?.codeVc()
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
    
    @objc func codeVc() {
        let dict = ["hello": "2"]
        guard let phoneStr = loginView.phoneText.text?.replacingOccurrences(of: " ", with: ""), phoneStr.count >= 10 else {
            MBProgressHUD.wj_showPlainText("Please enter a 10-digit mobile phone number", view: nil)
            return
        }
        ViewHud.addLoadView()
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/helloWord", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                let codeVc = PACodeViewController()
                codeVc.phoneStr = phoneStr
                self?.navigationController?.pushViewController(codeVc, animated: true)
            }
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
}
