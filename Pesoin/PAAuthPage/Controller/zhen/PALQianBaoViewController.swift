//
//  PALQianBaoViewController.swift
//  Pesoin
//
//  Created by apple on 2024/7/16.
//

import UIKit
import HandyJSON
import MBProgressHUD_WJExtension

class PALQianBaoViewController: PABaseViewController {
    
    var startime: String = ""
    
    var productID: String?
    
    var tupeStr: String = "1"
    
    var modelArray: [soundsModel]?
    
    var modelArray1: [soundsModel]?
    
    lazy var qianbaoView: PALQianBaoView = {
        let qianbaoView = PALQianBaoView()
        qianbaoView.titleLabel.text = "E-wallet&Bank"
        return qianbaoView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(qianbaoView)
        startime = PADeviceInfo.getCurrentTime()
        qianbaoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        qianbaoView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        qianbaoView.block2 = { [weak self] in
            self?.saveXinxi()
        }
        qianbaoView.block3 = { [weak self] sender in
            sender.isSelected = !sender.isSelected
            if sender.isSelected {
                self?.tupeStr = "2"//yinhangka
                let model = self?.modelArray?[1]
                self?.qianbaoView.modelArray = model?.sounds
                self?.modelArray1?.removeAll()
                self?.modelArray1 = model?.sounds
                self?.qianbaoView.tableView.reloadData()
                sender.setBackgroundImage(UIImage(named: "Slicewalle"), for: .normal)
            }else {
                self?.tupeStr = "1"//qianbao
                let model = self?.modelArray?[0]
                self?.qianbaoView.modelArray = model?.sounds
                self?.modelArray1?.removeAll()
                self?.modelArray1 = model?.sounds
                self?.qianbaoView.tableView.reloadData()
                sender.setBackgroundImage(UIImage(named: "Slicebank"), for: .normal)
            }
        }
        huoquyinhangka()
    }
}

extension PALQianBaoViewController {
    
    func huoquyinhangka() {
        ViewHud.addLoadView()
        PARequestManager.shared.requestAPI(params: [:], pageUrl: "/sicch/remainWrite", method: .get) { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed), let modelArray = model.sounds {
                    let model = modelArray[0]
                    self?.modelArray = modelArray
                    self?.qianbaoView.modelArray = model.sounds
                    self?.qianbaoView.tableView.reloadData()
                }
            }
            ViewHud.hideLoadView()
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func saveXinxi() {
        var dict: [String: Any]?
        if let modelArray = modelArray1 {
            dict = modelArray.reduce(into: [String: Any](), { partialResult, model in
                let type = model.taffeta
                if type == "rou1" || type == "rou3" {
                    partialResult[model.handsto!] = model.goneup
                }else {
                    partialResult[model.handsto!] = model.pester
                }
            })
            dict?["characterture"] = "1"
            dict?["affairs"] = self.productID ?? ""
            dict?["stairs"] = tupeStr
        }
        ViewHud.addLoadView()
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/flowerBiggern", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            let jiffy = baseModel.jiffy ?? ""
            if handsto == 0 || handsto == 00 {
                self?.detailPageInfo(productID: self?.productID ?? "", startTime: self?.startime ?? "", type: "") { model1, model2, productID in
                    let orderID = model1.nightshirts ?? ""
                    let step = model2.smoke ?? ""
                    if !step.isEmpty {
                        self?.nextStep(type: step, productID: productID)
                    }else {
                        //dingdantiaozhuan
                        self?.ordertVc(orderID: orderID, productID: productID)
                    }
                }
                self?.appmaidain(productID: self?.productID ?? "", type: "8", startTime: self?.startime ?? "")
            }
            ViewHud.hideLoadView()
            MBProgressHUD.wj_showPlainText(jiffy, view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
}
