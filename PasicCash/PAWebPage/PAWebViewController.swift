//
//  PAWebViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/16.
//

import UIKit

class PAWebViewController: PABaseViewController {
    
    var productID: String?
    
    var webStr: String?
    
    lazy var webPaView: PAWebView = {
        let webPaView = PAWebView()
        return webPaView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(webPaView)
        webPaView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        webPaView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        if let webStr = webStr {
            var urlString = ""
            urlString = webStr.replacingOccurrences(of: " ", with: "%20")
            if let url = URL(string: urlString) {
                webPaView.webView.load(URLRequest(url: url))
            }
        }
    }
    
}
