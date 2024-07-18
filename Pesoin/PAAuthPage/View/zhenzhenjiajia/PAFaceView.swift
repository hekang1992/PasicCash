//
//  PAFaceView.swift
//  Pesoin
//
//  Created by apple on 2024/7/11.
//

import UIKit

class PAFaceView: PACommonView {
    
    var block1: (() -> Void)?
    
    var block2: (() -> Void)?
    
    lazy var icon1: UIButton = {
        let icon1 = UIButton(type: .custom)
        icon1.setImage(UIImage(named: "Group_1091"), for: .normal)
        icon1.adjustsImageWhenHighlighted = false
        icon1.addTarget(self, action: #selector(btniconClick), for: .touchUpInside)
        return icon1
    }()
    
    lazy var icon2: UIButton = {
        let icon2 = UIButton(type: .custom)
        icon2.adjustsImageWhenHighlighted = false
        icon2.setImage(UIImage(named: "Group_969"), for: .normal)
        icon2.addTarget(self, action: #selector(btniconClick), for: .touchUpInside)
        return icon2
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.layer.cornerRadius = 30.ppaix()
        whiteView.layer.borderWidth = 4.ppaix()
        whiteView.backgroundColor = UIColor.init(hex: "#FDFFF6")
        whiteView.layer.borderColor = UIColor.init(hex: "#C6F14D").cgColor
        return whiteView
    }()
    
    lazy var icon3: UIImageView = {
        let icon3 = UIImageView()
        icon3.layer.cornerRadius = 32.ppaix()
        icon3.layer.masksToBounds = true
        icon3.contentMode = .scaleAspectFill
        icon3.image = UIImage(named: "Group_1021")
        return icon3
    }()
    
    lazy var icon4: UIImageView = {
        let icon4 = UIImageView()
        icon4.image = UIImage(named: "Group_10270")
        return icon4
    }()
    
    lazy var icon5: UIImageView = {
        let icon5 = UIImageView()
        icon5.image = UIImage(named: "Group_10250")
        return icon5
    }()
    
    lazy var icon6: UIImageView = {
        let icon6 = UIImageView()
        icon6.image = UIImage(named: "Group_10260")
        return icon6
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 15.ppaix())!, textColor: UIColor.init(hex: "#0CE094"), textAlignment: .center)
        descLabel.text = "Make sure you have good lighting, no obstructions, a natural expression, and remain relatively still."
        descLabel.numberOfLines = 0
        return descLabel
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
        let fullString = "Continue 2/3"
        let attributedString = NSMutableAttributedString(string: fullString)
        let color = UIColor.init(hex: "#FEE610")
        if let range = fullString.range(of: "Continue") {
            let nsRange = NSRange(range, in: fullString)
            let startIndex = nsRange.upperBound
            let remainingRange = NSRange(location: startIndex, length: fullString.count - startIndex)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: fullString.count))
            attributedString.addAttribute(.foregroundColor, value: color, range: remainingRange)
        }
        nextBtn.setAttributedTitle(attributedString, for: .normal)
        nextBtn.addTarget(self, action: #selector(photoClick), for: .touchUpInside)
        return nextBtn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.addSubview(icon1)
        scrollView.addSubview(icon2)
        scrollView.addSubview(whiteView)
        scrollView.addSubview(icon3)
        whiteView.addSubview(icon4)
        whiteView.addSubview(icon5)
        whiteView.addSubview(icon6)
        whiteView.addSubview(descLabel)
        scrollView.addSubview(icon7)
        scrollView.addSubview(descLabel1)
        scrollView.addSubview(nextBtn)
        icon1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(33.ppaix())
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 130.ppaix(), height: 75.ppaix()))
        }
        icon2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(33.ppaix())
            make.left.equalTo(icon1.snp.right).offset(15.ppaix())
            make.size.equalTo(CGSize(width: 205.ppaix(), height: 75.ppaix()))
        }
        whiteView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon2.snp.bottom).offset(37.5.ppaix())
            make.size.equalTo(CGSize(width: 325.ppaix(), height: 430.ppaix()))
        }
        icon3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon2.snp.bottom).offset(16.ppaix())
            make.size.equalTo(CGSize(width: 242.ppaix(), height: 242.ppaix()))
        }
        icon4.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10.ppaix())
            make.top.equalTo(icon3.snp.bottom).offset(23.ppaix())
            make.size.equalTo(CGSize(width: 75.ppaix(), height: 95.ppaix()))
        }
        icon5.snp.makeConstraints { make in
            make.left.equalTo(icon4.snp.right).offset(10.ppaix())
            make.top.equalTo(icon3.snp.bottom).offset(23.ppaix())
            make.size.equalTo(CGSize(width: 105.ppaix(), height: 95.ppaix()))
        }
        icon6.snp.makeConstraints { make in
            make.left.equalTo(icon5.snp.right).offset(10.ppaix())
            make.top.equalTo(icon3.snp.bottom).offset(23.ppaix())
            make.size.equalTo(CGSize(width: 105.ppaix(), height: 95.ppaix()))
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(35.ppaix())
            make.top.equalTo(icon6.snp.bottom).offset(20.ppaix())
        }
        icon7.snp.makeConstraints { make in
            make.top.equalTo(whiteView.snp.bottom).offset(33.ppaix())
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
            make.bottom.equalToSuperview().offset(-35.ppaix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PAFaceView {
    
    @objc func photoClick() {
        self.block1?()
    }
    
    @objc func btniconClick() {
        self.block2?()
    }
        
}
