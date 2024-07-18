//
//  PAPendingView.swift
//  Pesoin
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
        descLabel1.text = "Your data is used exclusively for approval, and Pesoin guarantees the protection of your privacy."
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
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 48.ppaix())!, textColor: UIColor.init(hex: "#0CE094"), textAlignment: .center)
        return timeLabel
    }()
    
    lazy var bgImage: UIImageView = {
        let bgImage = UIImageView()
        bgImage.image = UIImage(named: "Sliceqf13")
        return bgImage
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 12.ppaix())!, textColor: UIColor.init(hex: "#DADFCA"), textAlignment: .center)
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    lazy var bgImage1: UIImageView = {
        let bgImage1 = UIImageView()
        bgImage1.image = UIImage(named: "Slicrf14")
        return bgImage1
    }()
    
    lazy var bgImage2: UIImageView = {
        let bgImage2 = UIImageView()
        bgImage2.image = UIImage(named: "Sliceinfad14")
        return bgImage2
    }()
    
    lazy var bgImage3: UIImageView = {
        let bgImage3 = UIImageView()
        bgImage3.image = UIImage(named: "Slicepend")
        return bgImage3
    }()
    
    lazy var timeLabel1: UILabel = {
        let timeLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 16.ppaix())!, textColor: UIColor.init(hex: "#FFFFFF"), textAlignment: .right)
        return timeLabel
    }()
    
    lazy var timeLabel2: UILabel = {
        let timeLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 16.ppaix())!, textColor: UIColor.init(hex: "#FFFFFF"), textAlignment: .right)
        return timeLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.addSubview(jinduImageView)
        scrollView.addSubview(pendImageView)
        scrollView.addSubview(icon7)
        scrollView.addSubview(descLabel1)
        scrollView.addSubview(nextBtn)
        pendImageView.addSubview(timeLabel)
        pendImageView.addSubview(bgImage)
        pendImageView.addSubview(descLabel)
        pendImageView.addSubview(bgImage1)
        bgImage1.addSubview(timeLabel1)
        pendImageView.addSubview(bgImage2)
        bgImage2.addSubview(timeLabel2)
        pendImageView.addSubview(bgImage3)
        jinduImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.ppaix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.ppaix(), height: 44.5.ppaix()))
        }
        pendImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(jinduImageView.snp.bottom).offset(20.ppaix())
            make.size.equalTo(CGSize(width: 375.ppaix(), height: 475.ppaix()))
        }
        timeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(72.ppaix())
            make.left.equalToSuperview()
            make.height.equalTo(55.ppaix())
        }
        bgImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(timeLabel.snp.bottom).offset(10.ppaix())
            make.size.equalTo(CGSize(width: 284.ppaix(), height: 30.ppaix()))
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgImage.snp.bottom).offset(10.ppaix())
            make.width.equalTo(284.ppaix())
        }
        bgImage1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descLabel.snp.bottom).offset(15.ppaix())
            make.size.equalTo(CGSize(width: 284.ppaix(), height: 41.ppaix()))
        }
        bgImage2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgImage1.snp.bottom).offset(10.ppaix())
            make.size.equalTo(CGSize(width: 284.ppaix(), height: 41.ppaix()))
        }
        timeLabel1.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15.ppaix())
            make.top.bottom.equalToSuperview()
        }
        timeLabel2.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15.ppaix())
            make.top.bottom.equalToSuperview()
        }
        bgImage3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgImage2.snp.bottom).offset(10.ppaix())
            make.size.equalTo(CGSize(width: 284.ppaix(), height: 41.ppaix()))
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
        self.block?()
    }
    
}
