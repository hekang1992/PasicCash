//
//  PATabBarViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/2.
//

import UIKit

class PATabBarViewController: UITabBarController {
    
    lazy var customTabBar: PATabBar = {
        let customTabBar = PATabBar()
        return customTabBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addTabBar()
        addControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for child in self.tabBar.subviews {
            if let control = child as? UIControl {
                control.removeFromSuperview()
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tabBar.isHidden = true
        for child in self.tabBar.subviews {
            let className = NSStringFromClass(type(of: child))
            if className == "_UIBarBackground" || className == "UIBarBackground" {
                child.isHidden = true
            }
            if let control = child as? UIControl {
                control.removeFromSuperview()
            }
        }
    }
    
}

extension PATabBarViewController {
    
    func addTabBar(){
        view.addSubview(customTabBar)
        customTabBar.block = { [weak self] tabBar, from, to in
            if from == to {
                return
            }
            self?.selectedIndex = to
        }
        customTabBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.pix())
            make.bottom.equalToSuperview()
            make.height.equalTo(115.pix())
        }
    }
    
    func addControllers(){
        let homeVc = PAHomeViewController()
        let orderVc = PAOrderViewController()
        let userVc = PAUserViewController()
        self.setupChildViewController(childVc: homeVc, title: "Home", imageName: "home_nor", selectedImageName: "home_sel")
        self.setupChildViewController(childVc: orderVc, title: "Orders", imageName: "order_nor", selectedImageName: "order_sel")
        self.setupChildViewController(childVc: userVc, title: "Profile", imageName: "user_nor", selectedImageName: "user_sel")
    }
    
    func setupChildViewController(childVc: UIViewController, title: String, imageName: String, selectedImageName: String) {
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: imageName)
        if let selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal) {
            childVc.tabBarItem.selectedImage = selectedImage
        }
        let nav = PANavigationViewController(rootViewController: childVc)
        addChild(nav)
        customTabBar.addTabBarButtonNorImageUrl(imageName, selImageUrl: selectedImageName, title: title)
    }
    
}
