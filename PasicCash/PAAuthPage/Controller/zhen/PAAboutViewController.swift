//
//  PAAboutViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/17.
//

import UIKit

class PAAboutViewController: PABaseViewController {
    
    lazy var aboutView: PAAboutView = {
        let aboutView = PAAboutView()
        aboutView.titleLabel.text = "About us"
        return aboutView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(aboutView)
        aboutView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        aboutView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        aboutView.block1 = { [weak self] webStr in
            let webVc = PAWebViewController()
            webVc.webStr = webStr
            self?.navigationController?.pushViewController(webVc, animated: true)
        }
    }

}

