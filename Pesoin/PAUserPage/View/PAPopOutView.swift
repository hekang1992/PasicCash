//
//  PAPopOutView.swift
//  Pesoin
//
//  Created by apple on 2024/7/10.
//

import UIKit

class PAPopOutView: UIView {
    
    var block1: (() -> Void)?
    var block2: (() -> Void)?

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var agreeBtn: UIButton = {
        let agreeBtn = UIButton(type: .custom)
        agreeBtn.addTarget(self, action: #selector(agreeBtnClick), for: .touchUpInside)
        return agreeBtn
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        return cancelBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(agreeBtn)
        bgImageView.addSubview(cancelBtn)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.ppaix(), height: 525.ppaix()))
        }
        agreeBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(27.ppaix())
            make.bottom.equalToSuperview().offset(-45.ppaix())
            make.size.equalTo(CGSize(width: 120.ppaix(), height: 100.ppaix()))
        }
        cancelBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-27.ppaix())
            make.bottom.equalToSuperview().offset(-45.ppaix())
            make.left.equalTo(agreeBtn.snp.right)
            make.height.equalTo(100.ppaix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PAPopOutView {
    
    @objc func agreeBtnClick() {
        self.block1?()
    }
    
    @objc func cancelBtnClick() {
        self.block2?()
    }
    
}
