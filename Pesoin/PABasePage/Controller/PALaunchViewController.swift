//
//  PALaunchViewController.swift
//  Pesoin
//
//  Created by apple on 2024/7/2.
//

import UIKit

class PALaunchViewController: PABaseViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .gray
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH * 3, height: 0)
        return scrollView
    }()
    
    lazy var icon1: UIImageView = {
        let icon1 = UIImageView()
        icon1.isUserInteractionEnabled = true
        icon1.image = UIImage(named: "page1")
        icon1.contentMode = .scaleAspectFill
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped1))
        icon1.addGestureRecognizer(tapGesture)
        return icon1
    }()
    
    lazy var icon2: UIImageView = {
        let icon2 = UIImageView()
        icon2.isUserInteractionEnabled = true
        icon2.image = UIImage(named: "page2")
        icon2.contentMode = .scaleAspectFill
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped2))
        icon2.addGestureRecognizer(tapGesture)
        return icon2
    }()
    
    lazy var icon3: UIImageView = {
        let icon3 = UIImageView()
        icon3.isUserInteractionEnabled = true
        icon3.image = UIImage(named: "page3")
        icon3.contentMode = .scaleAspectFill
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped3))
        icon3.addGestureRecognizer(tapGesture)
        return icon3
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = UIImage(named: "launchimage")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        requestHuanJing()
    }

}

extension PALaunchViewController {
    
    func requestHuanJing() {
        PANetworkManager.shared.observeNetworkStatus { [weak self] status in
            switch status {
            case .none:
                print("无网络连接")
                break
            case .wifi:
                print("网络>>>>>>>WIFI")
                self?.requsetFirstApi()
                break
            case .cellular:
                print("网络>>>>>>>4G/5G")
                self?.requsetFirstApi()
                break
            }
        }
    }
    
    func requsetFirstApi() {
        let isShow = UserDefaults.standard.object(forKey: IS_SHOWLAND) as? String
        let dict = ["tfollow":"1", "hershe": "1"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/maudiebeenShouldnt", method: .get) { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if isShow != "1" && !IS_LOGIN {
                    self?.setupScrollView()
                } else {
                    self?.toRootVC()
                }
            }else {
                self?.requestHuanJing()
            }
        } errorBlock: { [weak self] error in
            self?.requestHuanJing()
        }
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(icon1)
        scrollView.addSubview(icon2)
        scrollView.addSubview(icon3)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        icon1.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT)
        }
        icon2.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(icon1.snp.right)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT)
        }
        icon3.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(icon2.snp.right)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT)
        }
        NotificationCenter.default.post(name: NSNotification.Name(IDFA_PA), object: nil, userInfo: nil)
    }
    
    @objc func imageTapped1() {
        scrollView.setContentOffset(CGPoint(x: SCREEN_WIDTH, y: 0), animated: true)
    }
    
    @objc func imageTapped2() {
        scrollView.setContentOffset(CGPoint(x: SCREEN_WIDTH * 2, y: 0), animated: true)
    }
    
    @objc func imageTapped3() {
        UserDefaults.standard.setValue("1", forKey: IS_SHOWLAND)
        UserDefaults.standard.synchronize()
        let borrowVc = PABorrowViewController()
        self.navigationController?.pushViewController(borrowVc, animated: true)
    }
    
    func toRootVC() {
        let loginStatus = IS_LOGIN ? "1" : "0"
        let dict = ["login": loginStatus]
        NotificationCenter.default.post(name: NSNotification.Name(IDFA_PA), object: nil, userInfo: nil)
        NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC), object: nil, userInfo: dict)
    }
    
}
