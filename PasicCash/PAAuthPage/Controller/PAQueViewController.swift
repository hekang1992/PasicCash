//
//  PAQueViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/12.
//

import UIKit

class PAQueViewController: PABaseViewController {
    
    var productID: String?
    
    lazy var queView: PAQueRenView = {
        let queView = PAQueRenView()
        queView.titleLabel.text = "Loan details"
        return queView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(queView)
        queView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        queView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
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
