//
//  PAShiYiViewController.swift
//  Pesoin
//
//  Created by apple on 2024/7/13.
//

import UIKit
import HandyJSON
import TYAlertController

class PAShiYiViewController: PABaseViewController {
    
    var productID: String?
    
    var startTime: String?
    
    lazy var shiyiView: PAShiYiView = {
        let shiyiView = PAShiYiView()
        shiyiView.titleLabel.text = "Card Type"
        return shiyiView
    }()
    
    lazy var popView: PAPopShiYiView = {
        let popView = PAPopShiYiView(frame: self.view.bounds)
        return popView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(shiyiView)
        shiyiView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        shiyiView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        shiyiView.block1 = { [weak self] model in
            self?.popQ(typeModel: model)
        }
        shiyiApi()
        startTime = PADeviceInfo.getCurrentTime()
    }
}

extension PAShiYiViewController {
    
    func shiyiApi() {
        ViewHud.addLoadView()
        let dict = ["affairs": self.productID ?? "", "againuntil": "2"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/threeNever", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed), let modelArray = model.undress {
                    self?.shiyiView.array = modelArray
                    self?.shiyiView.tableView.reloadData()
                }
            }
            ViewHud.hideLoadView()
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func popQ(typeModel: undressModel) {
        let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)
        popView.typeLabel.text = typeModel.goneup ?? ""
        popView.iconImageView.kf.setImage(with: URL(string: typeModel.lively ?? ""))
        self.present(alertVc!, animated: true)
        popView.block = { [weak self] in
            self?.dismiss(animated: true)
        }
        popView.block1 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                let authVc = PAAuthIDViewController()
                authVc.typeModel = typeModel
                authVc.productID = self?.productID
                self?.navigationController?.pushViewController(authVc, animated: true)
                self?.appmaidain(productID: self?.productID ?? "", type: "2", startTime: self?.startTime ?? "")
            })
        }
    }
    
}
