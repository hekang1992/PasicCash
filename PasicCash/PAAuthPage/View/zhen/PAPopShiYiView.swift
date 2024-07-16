//
//  PAPopShiYiView.swift
//  PasicCash
//
//  Created by apple on 2024/7/13.
//

import UIKit

class PAPopShiYiView: UIView {
    
    var block: (() -> Void)?
    
    var block1: (() -> Void)?

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hex: "#F4FDDA")
        bgView.layer.cornerRadius = 20.ppaix()
        return bgView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 32.ppaix())!, textColor: UIColor.init(hex: "#0CE094"), textAlignment: .center)
        titleLabel.text = "You have selected"
        return titleLabel
    }()
    
    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 32.ppaix())!, textColor: UIColor.init(hex: "#0CE094"), textAlignment: .center)
        return typeLabel
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        return iconImageView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 15.ppaix())!, textColor: UIColor.init(hex: "#719F60"), textAlignment: .center)
        descLabel.numberOfLines = 0
        descLabel.text = "Choosing a different ID type than the one uploaded can lead to a loan application denial. Please review your information carefully."
        return descLabel
    }()

    lazy var changeBtn: UIButton = {
        let changeBtn = UIButton(type: .custom)
        changeBtn.adjustsImageWhenHighlighted = false
        changeBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 24.ppaix())
        changeBtn.setTitleColor(UIColor.init(hex: "#FEE610"), for: .normal)
        changeBtn.setBackgroundImage(UIImage(named: "Group_1095"), for: .normal)
        changeBtn.setTitle("Change", for: .normal)
        changeBtn.addTarget(self, action: #selector(changeBtnClick), for: .touchUpInside)
        return changeBtn
    }()
    
    lazy var confirmBtn: UIButton = {
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.adjustsImageWhenHighlighted = false
        confirmBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 24.ppaix())
        confirmBtn.setTitleColor(UIColor.init(hex: "#FFFFFF"), for: .normal)
        confirmBtn.setBackgroundImage(UIImage(named: "Group_1095"), for: .normal)
        confirmBtn.setTitle("Confirm", for: .normal)
        confirmBtn.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
        return confirmBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(typeLabel)
        bgView.addSubview(iconImageView)
        bgView.addSubview(descLabel)
        bgView.addSubview(changeBtn)
        bgView.addSubview(confirmBtn)
        bgView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(587.ppaix())
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30.ppaix())
            make.left.equalToSuperview().offset(35.ppaix())
            make.height.equalTo(36.ppaix())
        }
        typeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalToSuperview().offset(35.ppaix())
            make.height.equalTo(36.ppaix())
        }
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 258.ppaix(), height: 158.ppaix()))
            make.top.equalTo(typeLabel.snp.bottom).offset(20.ppaix())
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(35.ppaix())
            make.top.equalTo(iconImageView.snp.bottom).offset(20.ppaix())
        }
        changeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descLabel.snp.bottom).offset(60.ppaix())
            make.size.equalTo(CGSize(width: 305.ppaix(), height: 60.ppaix()))
        }
        confirmBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(changeBtn.snp.bottom).offset(20.ppaix())
            make.size.equalTo(CGSize(width: 305.ppaix(), height: 60.ppaix()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PAPopShiYiView {
    
    
    @objc func changeBtnClick() {
        self.block?()
    }
    
    @objc func confirmBtnClick() {
        self.block1?()
    }
    
}
