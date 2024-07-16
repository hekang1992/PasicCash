//
//  PAOrderListController.swift
//  PasicCash
//
//  Created by apple on 2024/7/16.
//

import UIKit
import HandyJSON

class PAOrderListController: PABaseViewController {
    
    var titleStr: String?
    
    var orderType: String?
    
    lazy var listView: PAOrderListView = {
        let listView = PAOrderListView()
        listView.titleLabel.text = titleStr
        return listView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.listView.tableView.mj_header = PAPullHeader(refreshingTarget: self, refreshingAction: #selector(loadDate))
        listView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        listView.block1 = { [weak self] productUrl in
            self?.huoquapir(productUrl: productUrl)
        }
        listApi(type: self.orderType ?? "")
    }
    
}

extension PAOrderListController {
    
    func listApi(type: String) {
        ViewHud.addLoadView()
        let dict = ["sharply": type, "page": "1"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/repliesSimilar", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed), let modelArray = model.plants {
                    self?.listView.modelArray = modelArray
                    self?.nodataView.removeFromSuperview()
                }else {
                    self?.addNoda()
                }
            }
            ViewHud.hideLoadView()
            self?.listView.tableView.reloadData()
            self?.listView.tableView.mj_header?.endRefreshing()
        } errorBlock: { [weak self] error in
            self?.addNoda()
            ViewHud.hideLoadView()
            self?.listView.tableView.mj_header?.endRefreshing()
        }
    }
    
    func addNoda() {
        self.listView.addSubview(self.nodataView)
        self.nodataView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(self.listView.tableView.snp.top)
        }
    }
    
    @objc func loadDate() {
        listApi(type: self.orderType ?? "")
    }
    
    @objc func huoquapir(productUrl: String) {
        judguUrlSche(productUrl)
    }
    
}
