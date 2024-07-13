//
//  PAUserViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/2.
//

import UIKit
import HandyJSON
import MBProgressHUD_WJExtension
import TYAlertController

class PAUserViewController: PABaseViewController {
    
    lazy var userView: PAUserView = {
        let userView = PAUserView()
        return userView
    }()
    
    lazy var logOutView: PAPopOutView = {
        let logOutView = PAPopOutView(frame: self.view.bounds)
        logOutView.bgImageView.image = UIImage(named: "Group_1032")
        return logOutView
    }()
    
    lazy var delView: PAPopOutView = {
        let delView = PAPopOutView(frame: self.view.bounds)
        delView.bgImageView.image = UIImage(named: "Group_del")
        return delView
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
            self?.poplogout()
        }
        userView.block4 = { [weak self] in
            self?.popdelCount()
        }
        userView.block5 = { [weak self] in
            let youVc = PAYouHuiQuanViewController()
            PATabBarManager.hideTabBar()
            self?.navigationController?.pushViewController(youVc, animated: true)
        }
        userView.block6 = { [weak self] in
            MBProgressHUD.wj_showPlainText("about us", view: nil)
        }
        getPersonInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PATabBarManager.showTabBar()
    }
}


extension PAUserViewController {
    
    func getPersonInfo() {
        ViewHud.addLoadView()
        PARequestManager.shared.requestAPI(params: [:], pageUrl: "/sicch/whatArYour", method: .post) { [weak self] baseModel in
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
    
    func poplogout() {
        let alertVc = TYAlertController(alert: logOutView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        logOutView.block1 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                self?.logOut()
            })
        }
        logOutView.block2 = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    func popdelCount() {
        let alertVc = TYAlertController(alert: delView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        delView.block1 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                self?.delOut()
            })
        }
        delView.block2 = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    func logOut() {
        ViewHud.addLoadView()
        PARequestManager.shared.requestAPI(params: [:], pageUrl: "/sicch/atticusRegarded", method: .get) { [weak self] baseModel in
            let handsto = baseModel.handsto
            let jiffy = baseModel.jiffy ?? ""
            if handsto == 0 || handsto == 00 {
                self?.deleAccountInfo()
            }
            ViewHud.hideLoadView()
            MBProgressHUD.wj_showPlainText(jiffy, view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func delOut() {
        ViewHud.addLoadView()
        PARequestManager.shared.requestAPI(params: [:], pageUrl: "/sicch/planeGrinned", method: .get) { [weak self] baseModel in
            let handsto = baseModel.handsto
            let jiffy = baseModel.jiffy ?? ""
            if handsto == 0 || handsto == 00 {
                self?.deleAccountInfo()
            }
            ViewHud.hideLoadView()
            MBProgressHUD.wj_showPlainText(jiffy, view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func deleAccountInfo() {
        PALoginFactory.removeLoginInfo()
        NotificationCenter.default.post(name: Notification.Name(ROOT_VC), object: nil, userInfo: ["login": "0"])
    }
    
}

