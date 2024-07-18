//
//  PAYouHuiQuanViewController.swift
//  Pesoin
//
//  Created by apple on 2024/7/10.
//

import UIKit
import MBProgressHUD_WJExtension
import HandyJSON
import TYAlertController

class PAYouHuiQuanViewController: PABaseViewController {
    
    var block: (() -> Void)?
    
    lazy var youhuiView: PAYouHuiQuanView = {
        let youhuiView = PAYouHuiQuanView()
        youhuiView.titleLabel.text = "Discount Coupon"
        return youhuiView
    }()
    
    lazy var popYouView: PAUserYView = {
        let popYouView = PAUserYView(frame: self.view.bounds)
        return popYouView
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
        youhuiView.block1 = { [weak self] model in
            if model.riverbank == "1" {
                self?.userP()
            }else if model.riverbank == "2" {
                MBProgressHUD.wj_showPlainText("Coupon has been used", view: nil)
            }else {
                MBProgressHUD.wj_showPlainText("Coupon has expired", view: nil)
            }
        }
        getyouhuiquan()
        self.youhuiView.tableView.mj_header = PAPullHeader(refreshingTarget: self, refreshingAction: #selector(loadNeData))
    }
    
}

extension PAYouHuiQuanViewController {
    
    @objc func userP() {
        let alertVc = TYAlertController(alert: popYouView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        popYouView.block = { [weak self] in
            self?.dismiss(animated: true, completion: {
                self?.block?()
                self?.navigationController?.popViewController(animated: true)
            })
        }
        popYouView.block1 = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    @objc func loadNeData() {
        getyouhuiquan()
    }
    
    func getyouhuiquan() {
        let dict = ["whooped": "1"]
        ViewHud.addLoadView()
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/LoveMa", method: .post) { [weak self] baseModel in
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
