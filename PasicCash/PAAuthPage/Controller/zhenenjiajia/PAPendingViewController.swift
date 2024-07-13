//
//  PAPendingViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/12.
//

import UIKit
import MBProgressHUD_WJExtension

class PAPendingViewController: PABaseViewController {
    
    var productID: String?
    
    lazy var pendView: PAPendingView = {
        let pendView = PAPendingView()
        pendView.titleLabel.text = "Pending approval"
        return pendView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(pendView)
        pendView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        pendView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        pendApi()
    }
}

extension PAPendingViewController {
    
    @objc func pendApi() {
        ViewHud.addLoadView()
        let dict = ["affairs": self.productID ?? "", "withmiss": "1", "auth": "1"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/shelf/shelf/loan-detail", method: .post) { baseModel in
            let handsto = baseModel.handsto
            let jiffy = baseModel.jiffy ?? ""
            if handsto == 0 || handsto == 00 {
                
            }
            ViewHud.hideLoadView()
            MBProgressHUD.wj_showPlainText(jiffy, view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }

    }
    
}
