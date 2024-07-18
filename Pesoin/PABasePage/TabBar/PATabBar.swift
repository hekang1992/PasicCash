//
//  PATabBar.swift
//  Pesoin
//
//  Created by apple on 2024/7/2.
//

import UIKit

typealias PATabBarSelectionHandler = (_ tabBar: PATabBar, _ from: Int, _ to: Int) -> Void

class PATabBar: UIView {
    
    var block: PATabBarSelectionHandler?
    
    private var selectedButton: PATabBarButton?
    
    private var tabbarBtnArray: [PATabBarButton] = []
    
    private var norImageArr: [String] = []
    
    private var selImageArr: [String] = []
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.isUserInteractionEnabled = true
        icon.image = UIImage(named: "tabbar_bg")
        return icon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(icon)
        icon.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension PATabBar {
    
    func addTabBarButtonNorImageUrl(_ norImageUrl: String, selImageUrl: String, title: String) {
        let tabBarBtn = PATabBarButton()
        tabBarBtn.block = { [weak self] btn in
            self?.buttonClick(btn)
        }
        addSubview(tabBarBtn)
        tabBarBtn.setTabBarImage(url: norImageUrl, title: title)
        tabBarBtn.addTarget(self, action: #selector(buttonClick(_:)), for: .touchDown)
        tabbarBtnArray.append(tabBarBtn)
        norImageArr.append(norImageUrl)
        selImageArr.append(selImageUrl)
        if tabbarBtnArray.count == 1 {
            buttonClick(tabBarBtn)
            tabBarBtn.iconBtn.isSelected = true
        }
    }
    
    func ybDealSelectButton(_ ybButton: PATabBarButton) {
        for (index, currentButton) in tabbarBtnArray.enumerated() {
            if currentButton == ybButton {
                currentButton.iconBtn.isSelected = true
                currentButton.nameLabel.textColor = UIColor(hex: "#1C200D")
                currentButton.iconBtn.setImage(UIImage(named: selImageArr[index]), for: .normal)
            } else {
                currentButton.iconBtn.isSelected = false
                currentButton.nameLabel.textColor = UIColor(hex: "#E6E9ED")
                currentButton.iconBtn.setImage(UIImage(named: norImageArr[index]), for: .normal)
            }
        }
    }
    
    @objc private func buttonClick(_ button: PATabBarButton) {
        if let fromIndex = selectedButton?.tag {
            self.block?(self, fromIndex, button.tag)
        }
        selectedButton?.isSelected = false
        button.isSelected = true
        selectedButton = button
        ybDealSelectButton(selectedButton!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonW = frame.width / CGFloat(tabbarBtnArray.count)
        let buttonY = 1.ppaix()
        for (index, button) in tabbarBtnArray.enumerated() {
            let buttonX = CGFloat(index) * buttonW
            button.frame = CGRect(x: buttonX, y: CGFloat(buttonY), width: buttonW, height: 115.ppaix())
            button.tag = index
        }
    }
    
}
