//
//  PAAuthIDView.swift
//  PasicCash
//
//  Created by apple on 2024/7/11.
//

import UIKit

class PAAuthIDView: PACommonView {
    
    var block1: (() -> Void)?
    
    lazy var icon1: UIImageView = {
        let icon1 = UIImageView()
        icon1.image = UIImage(named: "Group_1086")
        return icon1
    }()
    
    lazy var icon2: UIImageView = {
        let icon2 = UIImageView()
        icon2.image = UIImage(named: "Group_960")
        return icon2
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.layer.cornerRadius = 30.pix()
        whiteView.layer.borderWidth = 4.pix()
        whiteView.backgroundColor = UIColor.init(hex: "#FDFFF6")
        whiteView.layer.borderColor = UIColor.init(hex: "#C6F14D").cgColor
        return whiteView
    }()
    
    lazy var icon3: UIImageView = {
        let icon3 = UIImageView()
        icon3.image = UIImage(named: "Group_1031")
        return icon3
    }()
    
    lazy var icon4: UIImageView = {
        let icon4 = UIImageView()
        icon4.image = UIImage(named: "Group_1027")
        return icon4
    }()
    
    lazy var icon5: UIImageView = {
        let icon5 = UIImageView()
        icon5.image = UIImage(named: "Group_1025")
        return icon5
    }()
    
    lazy var icon6: UIImageView = {
        let icon6 = UIImageView()
        icon6.image = UIImage(named: "Group_1026")
        return icon6
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.createLabel(font: UIFont(name: LilitaOneFont, size: 18.pix())!, textColor: UIColor.init(hex: "#0CE094"), textAlignment: .center)
        descLabel.text = "Please check that the type of the uploaded ID card matches the selected ID card type!"
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    lazy var icon7: UIImageView = {
        let icon7 = UIImageView()
        icon7.image = UIImage(named: "Group_1059")
        return icon7
    }()
    
    lazy var descLabel1: UILabel = {
        let descLabel1 = UILabel.createLabel(font: UIFont(name: LilitaOneFont, size: 9.pix())!, textColor: UIColor.init(hex: "#8D917F"), textAlignment: .left)
        descLabel1.text = "Your data is used exclusively for approval, and PasicCash guarantees the protection of your privacy."
        descLabel1.numberOfLines = 0
        return descLabel1
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 24.pix())
        nextBtn.adjustsImageWhenHighlighted = false
        nextBtn.setBackgroundImage(UIImage(named: "Group_1095"), for: .normal)
        let fullString = "Start 1/3"
        let attributedString = NSMutableAttributedString(string: fullString)
        let color = UIColor.init(hex: "#FEE610")
        if let range = fullString.range(of: "Start") {
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
        scrollView.addSubview(descLabel)
        scrollView.addSubview(icon7)
        scrollView.addSubview(descLabel1)
        scrollView.addSubview(nextBtn)
        icon1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(33.pix())
            make.left.equalToSuperview().offset(25.pix())
            make.size.equalTo(CGSize(width: 205.pix(), height: 75.pix()))
        }
        icon2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(33.pix())
            make.left.equalTo(icon1.snp.right).offset(15.pix())
            make.size.equalTo(CGSize(width: 105.pix(), height: 75.pix()))
        }
        whiteView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon2.snp.bottom).offset(37.5.pix())
            make.size.equalTo(CGSize(width: 325.pix(), height: 263.pix()))
        }
        icon3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon2.snp.bottom).offset(16.pix())
            make.size.equalTo(CGSize(width: 258.pix(), height: 158.pix()))
        }
        icon4.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10.pix())
            make.bottom.equalToSuperview().offset(-10.pix())
            make.size.equalTo(CGSize(width: 90.pix(), height: 95.pix()))
        }
        icon5.snp.makeConstraints { make in
            make.left.equalTo(icon4.snp.right).offset(10.pix())
            make.bottom.equalToSuperview().offset(-10.pix())
            make.size.equalTo(CGSize(width: 90.pix(), height: 95.pix()))
        }
        icon6.snp.makeConstraints { make in
            make.left.equalTo(icon5.snp.right).offset(10.pix())
            make.bottom.equalToSuperview().offset(-10.pix())
            make.size.equalTo(CGSize(width: 105.pix(), height: 95.pix()))
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(35.pix())
            make.top.equalTo(whiteView.snp.bottom).offset(25.pix())
        }
        icon7.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(121.pix())
            make.left.equalToSuperview().offset(35.pix())
            make.size.equalTo(CGSize(width: 16.pix(), height: 16.pix()))
        }
        descLabel1.snp.makeConstraints { make in
            make.width.equalTo(280.pix())
            make.left.equalTo(icon7.snp.right).offset(7.pix())
            make.top.equalTo(icon7.snp.top).offset(-2.5.pix())
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descLabel1.snp.bottom).offset(15.pix())
            make.size.equalTo(CGSize(width: 305.pix(), height: 60.pix()))
            make.bottom.equalToSuperview().offset(-35.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PAAuthIDView {
    
    @objc func photoClick() {
        self.block1?()
    }
    
}
