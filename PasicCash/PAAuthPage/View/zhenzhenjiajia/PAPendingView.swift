//
//  PAPendingView.swift
//  PasicCash
//
//  Created by apple on 2024/7/12.
//

import UIKit

class PAPendingView: PACommonView {

    lazy var jinduImageView: UIImageView = {
        let jinduImageView = UIImageView()
        jinduImageView.image = UIImage(named: "Group_1103")
        return jinduImageView
    }()
    
    lazy var pendImageView: UIImageView = {
        let pendImageView = UIImageView()
        pendImageView.image = UIImage(named: "Group_pend")
        return pendImageView
    }()
    
    lazy var icon7: UIImageView = {
        let icon7 = UIImageView()
        icon7.image = UIImage(named: "Group_1059")
        return icon7
    }()
    
    lazy var descLabel1: UILabel = {
        let descLabel1 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 9.ppaix())!, textColor: UIColor.init(hex: "#8D917F"), textAlignment: .left)
        descLabel1.text = "Your data is used exclusively for approval, and PasicCash guarantees the protection of your privacy."
        descLabel1.numberOfLines = 0
        return descLabel1
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 24.ppaix())
        nextBtn.adjustsImageWhenHighlighted = false
        nextBtn.setBackgroundImage(UIImage(named: "Group_1095"), for: .normal)
        nextBtn.setTitle("Back to home", for: .normal)
        nextBtn.addTarget(self, action: #selector(nextClick), for: .touchUpInside)
        return nextBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.addSubview(jinduImageView)
        scrollView.addSubview(pendImageView)
        scrollView.addSubview(icon7)
        scrollView.addSubview(descLabel1)
        scrollView.addSubview(nextBtn)
        jinduImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.ppaix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 267.ppaix(), height: 18.ppaix()))
        }
        pendImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(jinduImageView.snp.bottom).offset(20.ppaix())
            make.size.equalTo(CGSize(width: 375.ppaix(), height: 475.ppaix()))
        }
        icon7.snp.makeConstraints { make in
            make.top.equalTo(pendImageView.snp.bottom).offset(56.ppaix())
            make.left.equalToSuperview().offset(35.ppaix())
            make.size.equalTo(CGSize(width: 16.ppaix(), height: 16.ppaix()))
        }
        descLabel1.snp.makeConstraints { make in
            make.width.equalTo(280.ppaix())
            make.left.equalTo(icon7.snp.right).offset(7.ppaix())
            make.top.equalTo(icon7.snp.top).offset(-2.5.ppaix())
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descLabel1.snp.bottom).offset(15.ppaix())
            make.size.equalTo(CGSize(width: 305.ppaix(), height: 60.ppaix()))
            make.bottom.equalToSuperview().offset(-25.ppaix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PAPendingView {
    
    @objc func nextClick() {
        
    }
    
}
