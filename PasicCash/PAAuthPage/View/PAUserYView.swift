//
//  PAUserYView.swift
//  PasicCash
//
//  Created by apple on 2024/7/13.
//

import UIKit

class PAUserYView: UIView {
    
    var block: (() ->Void)?
    var block1: (() ->Void)?

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 30.pix()
        bgView.backgroundColor = UIColor.init(hex: "#FDFFF6")
        return bgView
    }()

    lazy var albumBtn: UIButton = {
        let albumBtn = UIButton(type: .custom)
        albumBtn.setTitle("YES", for: .normal)
        albumBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 27.pix())
        albumBtn.setTitleColor(UIColor.init(hex: "#1C200D"), for: .normal)
        albumBtn.addTarget(self, action: #selector(albumBtnClick), for: .touchUpInside)
        return albumBtn
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setTitle("NO", for: .normal)
        cancelBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 27.pix())
        cancelBtn.setTitleColor(UIColor.init(hex: "#CED4BD"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        return cancelBtn
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.createLabel(font: UIFont(name: LilitaOneFont, size: 25.pix())!, textColor: UIColor.init(hex: "#F84343"), textAlignment: .center)
        titleLabel.numberOfLines = 0
        titleLabel.text = "Would you like to use your coupon?"
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(albumBtn)
        bgView.addSubview(cancelBtn)
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 320.pix(), height: 180.pix()))
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.pix())
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(10.pix())
            make.height.equalTo(60.pix())
        }
        albumBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40.pix())
            make.left.equalToSuperview().offset(30.pix())
            make.bottom.equalToSuperview()
            make.width.equalTo(100.pix())
        }
        cancelBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40.pix())
            make.right.equalToSuperview().offset(-30.pix())
            make.bottom.equalToSuperview()
            make.width.equalTo(100.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PAUserYView {
    
    @objc func albumBtnClick() {
        self.block?()
    }
    
    @objc func cancelBtnClick() {
        self.block1?()
    }
    
}
