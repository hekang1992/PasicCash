//
//  PAYouHuiQuanViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/10.
//

import UIKit
import MBProgressHUD_WJExtension
import HandyJSON

class PAYouHuiQuanViewController: PABaseViewController {
    
    lazy var youhuiView: PAYouHuiQuanView = {
        let youhuiView = PAYouHuiQuanView()
        youhuiView.titleLabel.text = "Discount Coupon"
        return youhuiView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(youhuiView)
        youhuiView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        youhuiView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        getyouhuiquan()
        self.youhuiView.tableView.mj_header = PAPullHeader(refreshingTarget: self, refreshingAction: #selector(loadNeData))
    }
    
}

extension PAYouHuiQuanViewController {
    
    @objc func loadNeData() {
        getyouhuiquan()
    }
    
    func getyouhuiquan() {
        let dict = ["whooped": "1"]
        ViewHud.addLoadView()
        PARequestManager.shared.requestAPI(params: dict, pageUrl: youhui_quan, method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            let jiffy = baseModel.jiffy ?? ""
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed) {
                    self?.youhuiView.array = model.cashClas
                    self?.youhuiView.tableView.reloadData()
                }
            }
            ViewHud.hideLoadView()
            self?.youhuiView.tableView.mj_header?.endRefreshing()
            MBProgressHUD.wj_showPlainText(jiffy, view: nil)
        } errorBlock: { [weak self] error in
            ViewHud.hideLoadView()
            self?.youhuiView.tableView.mj_header?.endRefreshing()
        }

    }
    
}
