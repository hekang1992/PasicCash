//
//  PAPendingViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/12.
//

import UIKit

class PAPendingViewController: PABaseViewController {
    
    lazy var pendView: PAPendingView = {
        let pendView = PAPendingView()
        pendView.titleLabel.text = "Pending approval"
        return pendView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(pendView)
        pendView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        pendView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
}
