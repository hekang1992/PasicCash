//
//  PABorrowViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/3.
//

import UIKit
import MBProgressHUD_WJExtension

class PABorrowViewController: PABaseViewController {
    
    lazy var borrowView: PABorrowView = {
        let borrowView = PABorrowView()
        return borrowView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(borrowView)
        borrowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        borrowView.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        borrowView.block = { [weak self] in
            self?.nextVc()
        }
    }
}


extension PABorrowViewController {
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        let step: Float = 1000
        let roundedValue = round(sender.value / step) * step
        let amount = Int(roundedValue)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.currencySymbol = "₱"
        formatter.maximumFractionDigits = 0
        if let formattedAmount = formatter.string(from: NSNumber(value: amount)) {
            borrowView.nameLabel3.textColor = UIColor.init(hex: "#1C200D")
            borrowView.nameLabel3.text = formattedAmount
        }
        sender.value = roundedValue
    }
    
    func nextVc() {
        let str = self.borrowView.nameLabel3.text
        if str == "50,000 Max" {
            MBProgressHUD.wj_showPlainText("Please enter the amount you wish to borrow.", view: nil)
        }else {
            helloWord()
        }
    }
    
    func helloWord() {
        ViewHud.addLoadView()
        let dict = ["hello": "1"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/helloWord", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            let handsto = baseModel.handsto
            let jiffy = baseModel.jiffy
            if handsto == 0 || handsto == 00 {
                let loginVc = PALoginViewController()
                self?.navigationController?.pushViewController(loginVc, animated:true)
            }
            MBProgressHUD.wj_showPlainText(jiffy ?? "", view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
}
