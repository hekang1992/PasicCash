//
//  PAQueViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/12.
//

import UIKit
import HandyJSON
import MBProgressHUD_WJExtension
import BRPickerView

class PAQueViewController: PABaseViewController {
    
    var productID: String?
    
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
        queView.loanPurBlock = { [weak self] btn, array in
            self?.setupPickerView(array: array, btn: btn, title: "Purpose of loan")
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
            btn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 16.pix())
            btn.setTitleColor(UIColor.init(hex: "#0CE094"), for: .normal)
            btn.setTitle(province?.name ?? "", for: .normal)
        }
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = UIColor.init(hex: "#F4FDDA")
        customStyle.pickerTextFont = UIFont(name: LilitaOneFont, size: 18.pix())
        customStyle.selectRowTextFont = customStyle.pickerTextFont
        customStyle.selectRowTextColor = UIColor.init(hex: "#0CE094")
        stringPickerView.pickerStyle = customStyle
        stringPickerView.show()
    }
    
}
