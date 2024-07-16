//
//  PAOrderViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/2.
//

import UIKit

class PAOrderViewController: PABaseViewController {
    
    lazy var orderView: PAOrderView = {
        let orderView = PAOrderView()
        orderView.titleLabel.text = "Orders"
        orderView.backBtn.isHidden = true
        return orderView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(orderView)
        orderView.block1 = { [weak self] in
            self?.listOrderVc(type: "7", title: "Loan Under Review")
        }
        orderView.block2 = { [weak self] in
            self?.listOrderVc(type: "6", title: "Unpaid Loan Balance")
        }
        orderView.block3 = { [weak self] in
            self?.listOrderVc(type: "8", title: "Payment Failed")
        }
        orderView.block4 = { [weak self] in
            self?.listOrderVc(type: "5", title: "Fully Repaid")
        }
        orderView.block5 = { [weak self] in
            self?.listOrderVc(type: "9", title: "Repaid Within 2 Days")
        }
        orderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PATabBarManager.showTabBar()
    }
    
}


extension PAOrderViewController {
    
    func listOrderVc(type: String, title: String) {
        let listVc = PAOrderListController()
        listVc.orderType = type
        listVc.titleStr = title
        PATabBarManager.hideTabBar()
        self.navigationController?.pushViewController(listVc, animated: true)
    }
    
}
