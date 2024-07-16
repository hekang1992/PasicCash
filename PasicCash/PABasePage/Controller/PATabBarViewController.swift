//
//  PATabBarViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/2.
//

import UIKit

class PATabBarViewController: UITabBarController {
    
    private lazy var customTabBar: PATabBar = {
        let tabBar = PATabBar()
        return tabBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        configureViewControllers()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureTabBarVisibility()
    }
    
    private func setupTabBar() {
        view.addSubview(customTabBar)
        customTabBar.block = { [weak self] _, from, to in
            if from != to {
                self?.selectedIndex = to
            }
        }
        customTabBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.ppaix())
            make.bottom.equalToSuperview()
            make.height.equalTo(115.ppaix())
        }
    }
    
    private func configureViewControllers() {
        let homeVC = PAHomeViewController()
        let orderVC = PAOrderViewController()
        let userVC = PAUserViewController()
        
        setupChildViewController(homeVC, title: "Home", imageName: "home_nor", selectedImageName: "home_sel")
        setupChildViewController(orderVC, title: "Orders", imageName: "order_nor", selectedImageName: "order_sel")
        setupChildViewController(userVC, title: "Profile", imageName: "user_nor", selectedImageName: "user_sel")
    }
    
    private func setupChildViewController(_ viewController: PABaseViewController, title: String, imageName: String, selectedImageName: String) {
        viewController.title = title
        viewController.tabBarItem.image = UIImage(named: imageName)
        if let selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal) {
            viewController.tabBarItem.selectedImage = selectedImage
        }
        let navController = PANavigationViewController(rootViewController: viewController)
        addChild(navController)
        customTabBar.addTabBarButtonNorImageUrl(imageName, selImageUrl: selectedImageName, title: title)
    }
    
    private func configureTabBarVisibility() {
        tabBar.isHidden = true
        for subview in tabBar.subviews {
            let className = NSStringFromClass(type(of: subview))
            if className.contains("BarBackground") {
                subview.isHidden = true
            }
            if let control = subview as? UIControl {
                control.removeFromSuperview()
            }
        }
    }
    
    func showTabBar() {
        UIView.animate(withDuration: 0.25) {
            self.customTabBar.frame.origin.y = self.view.bounds.size.height - 115.ppaix()
        }
    }
    
    func hideTabBar() {
        UIView.animate(withDuration: 0.25) {
            self.customTabBar.frame.origin.y = self.view.bounds.size.height
        }
    }
}
