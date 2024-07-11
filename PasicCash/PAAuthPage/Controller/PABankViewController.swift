//
//  PABankViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/11.
//

import UIKit
import HandyJSON
import BRPickerView

class PABankViewController: PABaseViewController {
    
    lazy var bankView: PABankView = {
        let bankView = PABankView()
        bankView.titleLabel.text = "Bank Card"
        return bankView
    }()
    
    var productID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(bankView)
        bankView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bankView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        bankView.block1 = { [weak self] in
            self?.setupPickerView()
        }
        bankView.block2 = { [weak self] in
            
        }
        bankApi()
    }
    
}


extension PABankViewController {
    
    func bankApi() {
        let dict = ["withmiss": "1", "inher": "2"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/queklyFlash", method: .post) { baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed), let bankArrayModel = model.sounds?.last?.birds{
                    
                }
            }
        } errorBlock: { error in
            
        }
    }
    
    func setupPickerView() {
        let stringPickerView = BRStringPickerView()
        stringPickerView.pickerMode = .componentSingle
        stringPickerView.title = "学历"
        stringPickerView.dataSourceArr = ["大专以下", "大专", "本科", "硕士", "博士", "博士后"]
        stringPickerView.selectIndex = 2
        stringPickerView.resultModelBlock = { resultModel in
            if let resultModel = resultModel {
                self.bankView.bankBtn.setTitle(resultModel.value ?? "", for: .normal)
            }
        }
        
        stringPickerView.show()
    }
    
}
