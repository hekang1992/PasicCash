//
//  PALianxiViewController.swift
//  Pesoin
//
//  Created by apple on 2024/7/15.
//

import UIKit
import HandyJSON
import ContactsUI
import MBProgressHUD_WJExtension

class PALianxiViewController: PABaseViewController {
    
    var productID: String?
    
    var label1: UILabel?
    
    var label2: UILabel?
    
    var startime: String?
    
    var model: plantsModel?
    
    lazy var lianxiView: PALianxiView = {
        let lianxiView = PALianxiView()
        lianxiView.titleLabel.text = "Contact Information"
        return lianxiView
    }()
    
    lazy var pickerVc: CNContactPickerViewController = {
        let pickerVc = CNContactPickerViewController()
        pickerVc.delegate = self
        pickerVc.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        return pickerVc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(lianxiView)
        startime = PADeviceInfo.getCurrentTime()
        lianxiView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        lianxiView.block1 = { [weak self] model, label1, label2 in
            self?.model = model
            self?.label1 = label1
            self?.label2 = label2
            self?.popLianxiREN()
        }
        lianxiView.block2 = { [weak self] array in
            self?.uploadar(array:array)
        }
        lianxiView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        lianxiqingiqu()
    }
    
}

extension PALianxiViewController: CNContactPickerDelegate {
    
    func lianxiqingiqu() {
        ViewHud.addLoadView()
        let dict = ["affairs": self.productID ?? "", "fireplace": "1", "ispage": "1"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/oclockPlace", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed), let model = model.predictions, let modelArray = model.plants {
                    self?.lianxiView.modelArray = modelArray
                    self?.lianxiView.tableView.reloadData()
                }
            }
            ViewHud.hideLoadView()
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func popLianxiREN() {
        present(pickerVc, animated: true, completion: nil)
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let nameStr = contact.givenName + " " + contact.familyName
        if let phoneNumber = contact.phoneNumbers.first?.value {
            let numberStr = phoneNumber.stringValue
            if let label1 = self.label1, let label2 = self.label2{
                label1.text = nameStr
                label2.text = numberStr
                label1.textColor = UIColor.init(hex: "#0CE094")
                label2.textColor = UIColor.init(hex: "#0CE094")
                model?.erected = numberStr
                model?.hoses = nameStr
            }
        }
    }
    
    func uploadar(array: [[String: Any]]) {
        ViewHud.addLoadView()
        if let jsonData = try? JSONSerialization.data(withJSONObject: array, options: []) {
            if let jsonString = String(data: jsonData, encoding: .utf8), let productID = productID {
                let dict = ["affairs": productID, "shepointed": jsonString]
                PARequestManager.shared.uploadAPI(params: dict, pageUrl: "/sicch/tableMortgaged", method: .post, data: NSData() as Data, complete: { [weak self] baseModel in
                    let handsto = baseModel.handsto
                    let jiffy = baseModel.jiffy ?? ""
                    if handsto == 0 || handsto == 00 {
                        self?.detailPageInfo(productID: self?.productID ?? "", startTime: self?.startime ?? "", type: "") { model1, model2, productID in
                            self?.nextStep(type: model2.smoke ?? "", productID: productID)
                        }
                    }
                    ViewHud.hideLoadView()
                    MBProgressHUD.wj_showPlainText(jiffy, view: nil)
                }, errorBlock: { error in
                    ViewHud.hideLoadView()
                }, type: "")
            }
        }
    }
    
}
