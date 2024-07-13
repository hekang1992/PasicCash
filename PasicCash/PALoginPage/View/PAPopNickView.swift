//
//  PAPopNickView.swift
//  PasicCash
//
//  Created by apple on 2024/7/5.
//

import UIKit

class PAPopNickView: UIView {
    
    var block: (() ->Void)?
    
    var block1: (() ->Void)?

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 30.ppaix()
        bgView.backgroundColor = UIColor.init(hex: "#FDFFF6")
        return bgView
    }()
    
    lazy var tipLabel: UILabel = {
        let tipLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 20.ppaix())!, textColor: UIColor.init(hex: "#DC143C"), textAlignment: .center)
        tipLabel.text = "🌟NOTICE🌟"
        return tipLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 20.ppaix())!, textColor: UIColor.init(hex: "#DC143C"), textAlignment: .left)
        descLabel.numberOfLines = 0
        descLabel.text = "⚠️You can set a custom avatar and nickname or skip this step. If not set, a default avatar will be used."
        return descLabel
    }()

    lazy var albumBtn: UIButton = {
        let albumBtn = UIButton(type: .custom)
        albumBtn.setTitle("Go to Settings", for: .normal)
        albumBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 27.ppaix())
        albumBtn.setTitleColor(UIColor.init(hex: "#1C200D"), for: .normal)
        albumBtn.addTarget(self, action: #selector(albumBtnClick), for: .touchUpInside)
        return albumBtn
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setTitle("Skip", for: .normal)
        cancelBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 27.ppaix())
        cancelBtn.setTitleColor(UIColor.init(hex: "#CED4BD"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        return cancelBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(tipLabel)
        bgView.addSubview(descLabel)
        bgView.addSubview(albumBtn)
        bgView.addSubview(cancelBtn)
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 320.ppaix(), height: 320.ppaix()))
        }
        tipLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20.ppaix())
            make.height.equalTo(28.ppaix())
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tipLabel.snp.bottom)
            make.left.equalToSuperview().offset(20.ppaix())
            make.height.equalTo(130.ppaix())
        }
        albumBtn.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom)
            make.right.left.equalToSuperview()
            make.height.equalTo(80.ppaix())
        }
        cancelBtn.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(albumBtn.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PAPopNickView {
    
    @objc func albumBtnClick() {
        self.block?()
    }
    
    @objc func cancelBtnClick() {
        self.block1?()
    }

}
