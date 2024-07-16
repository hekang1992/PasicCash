//
//  PAWebViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/16.
//

import UIKit

class PAWebViewController: PABaseViewController {
    
    var productID: String?
    
    lazy var webView: PAWebView = {
        let webView = PAWebView()
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(webView)
        webView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
