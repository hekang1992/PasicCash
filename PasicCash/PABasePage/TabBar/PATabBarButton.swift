//
//  PATabBarButton.swift
//  PasicCash
//
//  Created by apple on 2024/7/2.
//

import UIKit
import SnapKit

class PATabBarButton: UIControl {
    
    let buttonW = (SCREEN_WIDTH - 40.pix()) / 3

    var block: ((PATabBarButton) -> Void)?
    
    lazy var iconBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.contentMode = .center
        button.addTarget(self, action: #selector(iconClick(_:)), for: .touchDown)
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.createLabel(font: UIFont(name: LilitaOneFont, size: 13.pix())!, textColor: UIColor(hex: "#E6E9ED"), textAlignment: .center)
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
    }
    
    private func addSubviews() {
        addSubview(iconBtn)
        addSubview(nameLabel)
        iconBtn.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalToSuperview().offset(21.5.pix())
            make.size.equalTo(CGSize(width: 32.pix(), height: 32.pix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconBtn.snp.bottom).offset(4.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: buttonW, height: 26.pix()))
        }
    }
    
    @objc func iconClick(_ sender: UIButton) {
        self.block?(self)
    }
    
    func setTabBarImage(url: String, title: String) {
        nameLabel.text = title
        iconBtn.setImage(UIImage(named: url), for: .normal)
    }
    
}
