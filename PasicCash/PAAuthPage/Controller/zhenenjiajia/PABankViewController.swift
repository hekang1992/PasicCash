//
//  PABankViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/11.
//

import UIKit
import HandyJSON
import BRPickerView
import MBProgressHUD_WJExtension
import TYAlertController

class PABankViewController: PABaseViewController {
    
    var bankArray: [BRProvinceModel]?
    
    var bankCode: String?
    
    var productID: String?
    
    lazy var bankView: PABankView = {
        let bankView = PABankView()
        bankView.titleLabel.text = "Bank Card"
        return bankView
    }()
    
    lazy var albumView: PAPopQueView = {
        let albumView = PAPopQueView(frame: self.view.bounds)
        return albumView
    }()
    
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
            if let bankArray = self?.bankArray, !bankArray.isEmpty {
                self?.setupPickerView(array: bankArray)
            }
        }
        bankView.block2 = { [weak self] in
            self?.saveBankInfo()
        }
        bankApi()
    }
    
}


extension PABankViewController {
    
    func bankApi() {
        let dict = ["withmiss": "1", "inher": "2"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/queklyFlash", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed), let bankArrayModel = model.sounds?.last?.birds{
                    let bankArray = yijiModel.getSimpleModelArr(dataSourceArr: bankArrayModel)
                    self?.bankArray = bankArray
                }
            }
        } errorBlock: { error in
            
        }
    }
    
    func setupPickerView(array: [BRProvinceModel]) {
        let stringPickerView = BRAddressPickerView()
        stringPickerView.pickerMode = .province
        stringPickerView.title = "Bank Info"
        stringPickerView.dataSourceArr = array
        stringPickerView.selectIndexs = [0]
        stringPickerView.resultBlock = { [weak self] province, city, area in
            self?.bankCode = province?.code
            self?.bankView.bankBtn.setTitle(province?.name ?? "", for: .normal)
        }
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = UIColor.init(hex: "#F4FDDA")
        customStyle.pickerTextFont = UIFont(name: LilitaOneFont, size: 18.ppaix())
        customStyle.selectRowTextFont = customStyle.pickerTextFont
        customStyle.selectRowTextColor = UIColor.init(hex: "#0CE094")
        stringPickerView.pickerStyle = customStyle
        stringPickerView.show()
    }
    
    func saveBankInfo() {
        ViewHud.addLoadView()
        let dict = ["thestreet": bankView.phoneText.text ?? "", "crook": bankCode ?? "", "characterture": "1"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/readGl", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            let jiffy = baseModel.jiffy ?? ""
            if handsto == 0 || handsto == 00 {
                self?.popQue()
            }
            ViewHud.hideLoadView()
            MBProgressHUD.wj_showPlainText(jiffy, view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func popQue() {
        let alertVc = TYAlertController(alert: albumView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        albumView.block = { [weak self] in
            self?.dismiss(animated: true, completion: {
                let queVc = PAQueViewController()
                queVc.productID = self?.productID
                self?.navigationController?.pushViewController(queVc, animated: true)
            })
        }
    }
    
}
