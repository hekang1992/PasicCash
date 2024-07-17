//
//  PAWebView.swift
//  PasicCash
//
//  Created by apple on 2024/7/16.
//

import UIKit
import WebKit
import MBProgressHUD_WJExtension

class PAWebView: PACommonView {
    
    var webUrl: String?
    
    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        let scriptNames = ["grownHeard", "courteousCough", "radleyMarch", "thatsAgain", "anybodyFront", "alwaystookUnder", "shirtThere", "appletonHands", "youHomemade"]
        for scriptName in scriptNames {
            userContentController.add(self, name: scriptName)
        }
        configuration.userContentController = userContentController
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.bounces = false
        webView.scrollView.alwaysBounceVertical = false
        webView.navigationDelegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        return webView
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(frame: .zero)
        progressView.tintColor = UIColor.init(hex: "#384067")
        progressView.trackTintColor = UIColor.groupTableViewBackground
        return progressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(webView)
        webView.addSubview(progressView)
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(scrollView.snp.top)
        }
        progressView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(2.ppaix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PAWebView: WKScriptMessageHandler, WKNavigationDelegate {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            if let progress = change?[.newKey] as? CGFloat {
                self.progressView.progress = Float(progress)
                if progress >= 1.0 {
                    UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
                        self.progressView.alpha = 0
                    }, completion: nil)
                }
            }
        } else if keyPath == #keyPath(WKWebView.title) {
            if let newTitle = change?[.newKey] as? String {
                DispatchQueue.main.async { [weak self] in
                    self?.titleLabel.text = newTitle
                }
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        ViewHud.hideLoadView()
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        let urlStr = url.absoluteString
        if urlStr.hasPrefix("mailto:") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else if urlStr.hasPrefix("whatsapp:") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                MBProgressHUD.wj_showPlainText("WhatsApp is not installed. Please install it.", view: nil)
            }
        }
        if urlStr.hasPrefix("mailto:") || urlStr.hasPrefix("whatsapp:") {
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        ViewHud.addLoadView()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ViewHud.hideLoadView()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        ViewHud.hideLoadView()
    }
    
}
