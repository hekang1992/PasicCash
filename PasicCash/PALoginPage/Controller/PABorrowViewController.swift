//
//  PABorrowViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/3.
//

import UIKit

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
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
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
            borrowView.nameLabel3.text = formattedAmount
        }
        sender.value = roundedValue
        
    }
    
}
