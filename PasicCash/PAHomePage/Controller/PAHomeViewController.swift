//
//  PAHomeViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/2.
//

import UIKit
import HandyJSON

class PAHomeViewController: PABaseViewController {
    
    lazy var oneView: PABigCardView = {
        let oneView = PABigCardView()
        return oneView
    }()
    
    lazy var twoView: PAProductView = {
        let twoView = PAProductView()
        return twoView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(oneView)
        oneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.oneView.tableView.mj_header = PAPullHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        oneView.block = { [weak self] productID in
            self?.applyClick(productID: productID) { nightwas in
                self?.judguUrlSche(nightwas)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeDataApi()
        PATabBarManager.showTabBar()
    }
    
}

extension PAHomeViewController {
    
    @objc func loadNewData() {
        homeDataApi()
    }
    
    func homeDataApi() {
        ViewHud.addLoadView()
        PARequestManager.shared.requestAPI(params: [:], pageUrl: "/sicch/smallStrolled", method: .get) { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed) {
                    self?.oneView.bannerModel = model.likethat
                    self?.oneView.bigModel = model.saidjem
                    self?.oneView.authModel = model.andcrept
                    self?.oneView.secModel = model.credential
                    self?.oneView.reqImgModel = model.reqImg
                    self?.oneView.rankModel = model.req
                }
            }
            ViewHud.hideLoadView()
            self?.oneView.tableView.reloadData()
            self?.oneView.tableView.mj_header?.endRefreshing()
        } errorBlock: { [weak self] error in
            ViewHud.hideLoadView()
            self?.oneView.tableView.mj_header?.endRefreshing()
        }
    }
    
}
