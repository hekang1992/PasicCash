//
//  PAWorkViewController.swift
//  Pesoin
//
//  Created by apple on 2024/7/15.
//

import UIKit
import HandyJSON
import BRPickerView
import MBProgressHUD_WJExtension

class PAWorkViewController: PABaseViewController {
    
    var startime: String = ""
    
    var productID: String?
    
    var block: (() -> Void)?
    
    var dizhiArray: [plantsModel]?
    
    var modelArray: [soundsModel]?
    
    lazy var gereView: PAGeRenView = {
        let gereView = PAGeRenView()
        gereView.titleLabel.text = "Work Information"
        gereView.scrollView.isHidden = true
        return gereView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(gereView)
        startime = PADeviceInfo.getCurrentTime()
        gereView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        gereView.block1 = { [weak self] inputField, model in
            self?.addressHH(sounmodel: model, textField: inputField)
        }
        gereView.block2 = { [weak self] in
            self?.saveXinxi()
        }
        gereView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        GreWork()
    }
}

extension PAWorkViewController {
    
    func GreWork() {
        ViewHud.addLoadView()
        let dict = ["affairs": self.productID ?? ""]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/streetandHeard", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed), let modelArray = model.sounds {
                    self?.gereView.modelArray = modelArray
                    self?.modelArray = modelArray
                    self?.gereView.tableView.reloadData()
                }
            }
            ViewHud.hideLoadView()
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
        
    }
    
    func addressHH(sounmodel: soundsModel, textField: UITextField) {
        if let dizhiArray = self.dizhiArray, !dizhiArray.isEmpty {
            self.setupPickerView(model: sounmodel, textField: textField, array: dizhiArray)
            return
        }
        ViewHud.addLoadView()
        PARequestManager.shared.requestAPI(params: [:], pageUrl: "/sicch/granddaddyOfcordiality", method: .get) { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed), let dizhiArray = model.plants {
                    self?.dizhiArray = dizhiArray
                    self?.setupPickerView(model: sounmodel, textField: textField, array: dizhiArray)
                }
            }
            ViewHud.hideLoadView()
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func setupPickerView(model: soundsModel, textField: UITextField, array: [plantsModel]) {
        let stringPickerView = BRAddressPickerView()
        stringPickerView.pickerMode = .area
        let bridsArray = sanjiModel.getsanjiArr(dataSourceArr: array)
        stringPickerView.title = model.andmen ?? ""
        stringPickerView.dataSourceArr = bridsArray
        stringPickerView.selectIndexs = [0]
        stringPickerView.resultBlock = { province, city, area in
            textField.font = UIFont(name: LilitaOneFont, size: 20.ppaix())
            textField.tintColor = UIColor.init(hex: "#0CE094")
            let provinceName = province?.name ?? ""
            let cityName = city?.name ?? ""
            let areaName = area?.name ?? ""
            let addressString = provinceName + " - " + cityName + " - " + areaName
            textField.text = addressString
            model.goneup = addressString
        }
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = UIColor.init(hex: "#F4FDDA")
        customStyle.pickerTextFont = UIFont(name: LilitaOneFont, size: 18.ppaix())
        customStyle.selectRowTextFont = customStyle.pickerTextFont
        customStyle.selectRowTextColor = UIColor.init(hex: "#0CE094")
        stringPickerView.pickerStyle = customStyle
        stringPickerView.show()
    }
    
    func saveXinxi() {
        var dict: [String: Any]?
        if let modelArray = modelArray {
            dict = modelArray.reduce(into: [String: Any](), { partialResult, model in
                let type = model.taffeta
                if type == "rou1" || type == "rou3" {
                    partialResult[model.handsto!] = model.goneup
                }else {
                    partialResult[model.handsto!] = model.pester
                }
            })
            dict?["affairs"] = self.productID ?? ""
            dict?["helpless"] = "1"
        }
        ViewHud.addLoadView()
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/tousledCondescension", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            let jiffy = baseModel.jiffy ?? ""
            if handsto == 0 || handsto == 00 {
                self?.detailPageInfo(productID: self?.productID ?? "", startTime: self?.startime ?? "", type: "") { model1, model2, productID in
                    self?.nextStep(type: model2.smoke ?? "", productID: productID)
                    self?.appmaidain(productID: self?.productID ?? "", type: "6", startTime: self?.startime ?? "")
                }
            }
            ViewHud.hideLoadView()
            MBProgressHUD.wj_showPlainText(jiffy, view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
}
