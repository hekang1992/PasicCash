//
//  PAPendingViewController.swift
//  Pesoin
//
//  Created by apple on 2024/7/12.
//

import UIKit
import HandyJSON
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
            self?.navigationController?.popViewController(animated: true)
        }
        pendApi()
    }
}

extension PAPendingViewController {
    
    @objc func pendApi() {
        ViewHud.addLoadView()
        let dict = ["affairs": self.productID ?? "", "withmiss": "1", "auth": "1"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/assistance", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            let jiffy = baseModel.jiffy ?? ""
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed), let array = model.perfect {
                    if let date = DateConverter.date(from: model.flowFind ?? "") {
                        CountdownManager.startCountdown(startDate: date, duration: 15 * 60) { [weak self] hours, minutes, seconds in
                            DispatchQueue.main.async {
                                self?.pendView.timeLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                                if self?.pendView.timeLabel.text == "00:00:00" {
                                    self?.pendView.timeLabel.text = "In Review"
                                }
                            }
                        }
                    }
                    self?.pendView.descLabel.text = model.usingWare
                    self?.pendView.timeLabel1.text = array[0].cocoa
                    self?.pendView.timeLabel2.text = array[1].cocoa
                }
            }
            ViewHud.hideLoadView()
            MBProgressHUD.wj_showPlainText(jiffy, view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }

    }
    
}
