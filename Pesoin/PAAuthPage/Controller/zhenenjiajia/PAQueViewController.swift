//
//  PAQueViewController.swift
//  Pesoin
//
//  Created by apple on 2024/7/12.
//

import UIKit
import HandyJSON
import MBProgressHUD_WJExtension
import BRPickerView

class PAQueViewController: PABaseViewController {
    
    var productID: String?
    
    var moneyStr: String?
    
    lazy var queView: PAQueRenView = {
        let queView = PAQueRenView()
        queView.titleLabel.text = "Loan details"
        return queView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(queView)
        queView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        queView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        queView.block1 = { [weak self] str in
            self?.moneyStr = str
        }
        queView.loanPurBlock = { [weak self] btn, array in
            self?.setupPickerView(array: array, btn: btn, title: "Purpose of loan")
        }
        queView.loanPurBlock1 = { [weak self] btn, array in
            let youVc = PAYouHuiQuanViewController()
            youVc.block = {
                btn.setTitle("Used 10% off coupon", for: .normal)
            }
            self?.navigationController?.pushViewController(youVc, animated: true)
        }
        queView.loanPurBlock2 = { [weak self] btn, array in
            self?.setupPickerView(array: array, btn: btn, title: "Repayment period")
        }
        queView.saveBlock = { [weak self] in
            self?.sureQueMoney()
        }
        queView.block2 = { [weak self] in
            self?.pushWeb(productID: "", webUrl: "https://pasigborongan.com/scaerdsaf")
        }
        getLoanDetail()
    }
    
}

extension PAQueViewController {
    
    func getLoanDetail() {
        ViewHud.addLoadView()
        let dict = ["backing": productID ?? "", "awoke": "1"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/approvalVal", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            let jiffy = baseModel.jiffy ?? ""
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed), let array = model.twitch {
                    self?.queView.array = array
                    self?.queView.tableView.reloadData()
                }
            }
            ViewHud.hideLoadView()
            MBProgressHUD.wj_showPlainText(jiffy, view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func setupPickerView(array: [BRProvinceModel], btn: UIButton, title: String) {
        let stringPickerView = BRAddressPickerView()
        stringPickerView.pickerMode = .province
        stringPickerView.title = title
        stringPickerView.dataSourceArr = array
        stringPickerView.selectIndexs = [0]
        stringPickerView.resultBlock = { province, city, area in
            btn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 16.ppaix())
            btn.setTitleColor(UIColor.init(hex: "#0CE094"), for: .normal)
            btn.setTitle(province?.name ?? "", for: .normal)
        }
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = UIColor.init(hex: "#F4FDDA")
        customStyle.pickerTextFont = UIFont(name: LilitaOneFont, size: 18.ppaix())
        customStyle.selectRowTextFont = customStyle.pickerTextFont
        customStyle.selectRowTextColor = UIColor.init(hex: "#0CE094")
        stringPickerView.pickerStyle = customStyle
        stringPickerView.show()
    }
    
    func sureQueMoney() {
        ViewHud.addLoadView()
        let dict = ["backing": productID ?? "", "punywhen": self.moneyStr ?? "30000", "natural": "90", "awoke": "1", "househe": "3", "cashClas": "1", "nature": "1", "issendCode": "1"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/titleWork", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            let jiffy = baseModel.jiffy ?? ""
            if handsto == 0 || handsto == 00 {
                let pendVc = PAPendingViewController()
                pendVc.productID = self?.productID
                self?.navigationController?.pushViewController(pendVc, animated: true)
            }
            ViewHud.hideLoadView()
            MBProgressHUD.wj_showPlainText(jiffy, view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
}
