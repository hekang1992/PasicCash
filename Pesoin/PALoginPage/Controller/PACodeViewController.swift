//
//  PACodeViewController.swift
//  Pesoin
//
//  Created by apple on 2024/7/4.
//

import UIKit
import MBProgressHUD_WJExtension
import TYAlertController
import HandyJSON

class PACodeViewController: PABaseViewController {
    
    var totalTime = 60
    
    var phoneStr: String = ""
    
    var countdownTimer: Timer!
    
    var startTime: String?
    
    lazy var codeView: PACodeView = {
        let codeView = PACodeView()
        return codeView
    }()
    
    lazy var popNickView: PAPopNickView = {
        let popNickView = PAPopNickView(frame: self.view.bounds)
        return popNickView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(codeView)
        codeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        codeView.block = { [weak self] in
            self?.loginApi()
        }
        codeView.block1 = { [weak self] in
            self?.getCodeApi()
        }
        codeView.block2 = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        getCodeApi()
        startTime = PADeviceInfo.getCurrentTime()
    }
    
}


extension PACodeViewController {
    
    func startTimer() {
        self.codeView.codeBtn.isEnabled = false
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        if totalTime > 0 {
            totalTime -= 1
            UIView.animate(withDuration: 0.25) {
                self.codeView.codeBtn.setTitle("", for: .normal)
                self.codeView.codeBtn.setTitleColor(UIColor.init(hex: "#FEE610"), for: .normal)
                self.codeView.codeBtn.layer.cornerRadius = 20.ppaix()
                self.codeView.codeBtn.snp.updateConstraints { make in
                    make.size.equalTo(CGSizeMake(40.ppaix(), 40.ppaix()))
                }
                self.codeView.layoutIfNeeded()
            } completion: { _ in
                self.codeView.codeBtn.setTitle("\(self.totalTime)s", for: .normal)
            }
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        self.codeView.codeBtn.isEnabled = true
        self.codeView.codeBtn.setTitle("Resend code", for: .normal)
        UIView.animate(withDuration: 0.25) {
            self.codeView.codeBtn.layer.cornerRadius = 15.ppaix()
            self.codeView.codeBtn.setTitleColor(UIColor.white, for: .normal)
            self.codeView.codeBtn.snp.updateConstraints { make in
                make.size.equalTo(CGSizeMake(110.ppaix(), 40.ppaix()))
            }
            self.codeView.layoutIfNeeded()
        }
        totalTime = 60
    }
    
    func getCodeApi() {
        ViewHud.addLoadView()
        let dict = ["chuckling": phoneStr, "whooped": "1"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/exactlyScalp", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            let handsto = baseModel.handsto
            let jiffy = baseModel.jiffy
            if handsto == 0 || handsto == 00 {
                self?.startTimer()
            }
            MBProgressHUD.wj_showPlainText(jiffy ?? "", view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func loginApi() {
        let codeStr = codeView.phoneText.text?.replacingOccurrences(of: " ", with: "")
        ViewHud.addLoadView()
        let dict = ["ruined": phoneStr, "driedblood": codeStr ?? ""]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/twelveWould", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            let jiffy = baseModel.jiffy ?? ""
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<LoginModel>.deserializeFrom(dict: baseModel.shepointed) {
                    PALoginFactory.removeLoginInfo()
                    PALoginFactory.saveLoginInfo(model.ruined ?? "", model.baffled ?? "")
                }
                self?.popView()
                self?.appmaidain(productID: "", type: "1", startTime: self?.startTime ?? "")
            }
            ViewHud.hideLoadView()
            MBProgressHUD.wj_showPlainText(jiffy, view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func popView() {
        let alertVc = TYAlertController(alert: popNickView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        popNickView.block = { [weak self] in
            self?.dismiss(animated: true, completion: {
                let nickVc = PANickViewController()
                self?.navigationController?.pushViewController(nickVc, animated: true)
            })
        }
        popNickView.block1 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                NotificationCenter.default.post(name: Notification.Name(ROOT_VC), object: nil, userInfo: ["login": "1"])
            })
        }
    }
}
