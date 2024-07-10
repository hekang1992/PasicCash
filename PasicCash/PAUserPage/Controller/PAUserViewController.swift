//
//  PAUserViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/2.
//

import UIKit
import HandyJSON
import MBProgressHUD_WJExtension

class PAUserViewController: PABaseViewController {
    
    lazy var userView: PAUserView = {
        let userView = PAUserView()
        return userView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(userView)
        userView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        userView.block1 = { [weak self] in
            MBProgressHUD.wj_showPlainText("1", view: nil)
        }
        userView.block2 = { [weak self] in
            MBProgressHUD.wj_showPlainText("2", view: nil)
        }
        userView.block3 = { [weak self] in
            MBProgressHUD.wj_showPlainText("3", view: nil)
        }
        userView.block4 = { [weak self] in
            MBProgressHUD.wj_showPlainText("4", view: nil)
        }
        getPersonInfo()
    }
}


extension PAUserViewController {
    
    func getPersonInfo() {
        ViewHud.addLoadView()
        PARequestManager.shared.requestAPI(params: [:], pageUrl: get_nick, method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed), let nickModel = model.overcoat {
                    self?.setUpIcon(nickModel.bearuft ?? "", nickModel.chuckling ?? "", nickModel.clank ?? "", nickModel.shutDown ?? "", nickModel.shutUp ?? "")
                }
            }
            ViewHud.hideLoadView()
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func setUpIcon(_ user: String, _ phone: String, _ nick: String, _ desc: String, _ title: String) {
        userView.iconImageView.kf.setImage(with: URL(string: user), placeholder: UIImage(named: "Group_987"))
        userView.phoneLabel.text = phone
        userView.nickLabel.text = nick
        userView.descLabel.text = desc
        userView.titleLabel.text = title
    }
    
}

