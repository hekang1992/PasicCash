//
//  PAUserView.swift
//  PasicCash
//
//  Created by apple on 2024/7/10.
//

import UIKit

class PAUserView: UIView {
    
    var block1: (() -> Void)?
    
    var block2: (() -> Void)?
    
    var block3: (() -> Void)?
    
    var block4: (() -> Void)?
    
    var block5: (() -> Void)?
    
    var block6: (() -> Void)?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.layer.cornerRadius = 35.ppaix()
        iconImageView.layer.masksToBounds = true
        iconImageView.image = UIImage(named: "Group_987")
        return iconImageView
    }()
    
    lazy var iconImageView1: UIImageView = {
        let iconImageView1 = UIImageView()
        iconImageView1.image = UIImage(named: "Ma_group")
        return iconImageView1
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .center)
        phoneLabel.text = "Hello, dear friend!"
        return phoneLabel
    }()
    
    lazy var nickLabel: UILabel = {
        let nickLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 24.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .center)
        nickLabel.text = ""
        return nickLabel
    }()

    lazy var iconImageView2: UIButton = {
        let iconImageView2 = UIButton(type: .custom)
        iconImageView2.setImage(UIImage(named: "Group_1020"), for: .normal)
        iconImageView2.adjustsImageWhenHighlighted = false
        iconImageView2.addTarget(self, action: #selector(youhuiquanClick), for: .touchUpInside)
        return iconImageView2
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1E230F"), textAlignment: .center)
        titleLabel.text = ""
        return titleLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 16.ppaix())!, textColor: UIColor.init(hex: "#0CE094"), textAlignment: .center)
        descLabel.text = ""
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    lazy var aboutBtn: UIButton = {
        let aboutBtn = UIButton(type: .custom)
        aboutBtn.adjustsImageWhenHighlighted = false
        aboutBtn.setImage(UIImage(named: "Group_1093"), for: .normal)
        aboutBtn.addTarget(self, action: #selector(aboutClick), for: .touchUpInside)
        return aboutBtn
    }()
    
    lazy var agreeView: PAExpanView = {
        let agreeView = PAExpanView()
        agreeView.backgroundColor = UIColor.init(hex: "#FDFFF6")
        agreeView.layer.cornerRadius = 20.ppaix()
        agreeView.agreeBtn.setTitle("Agreements", for: .normal)
        agreeView.daikuanBtn.setTitle("Loan Policy", for: .normal)
        agreeView.yinsiBtn.setTitle("Privacy Policy", for: .normal)
        agreeView.yinsiBtn.setTitleColor(UIColor.init(hex: "#0CE094"), for: .normal)
        agreeView.daikuanBtn.setTitleColor(UIColor.init(hex: "#0CE094"), for: .normal)
        agreeView.block1 = { [weak self] in
            self?.block1?()
        }
        agreeView.block2 = { [weak self] in
            self?.block2?()
        }
        return agreeView
    }()
    
    lazy var accountView: PAExpanView = {
        let accountView = PAExpanView()
        accountView.backgroundColor = UIColor.init(hex: "#FDFFF6")
        accountView.layer.cornerRadius = 20.ppaix()
        accountView.agreeBtn.setTitle("Account Settings", for: .normal)
        accountView.daikuanBtn.setTitle("Log Out", for: .normal)
        accountView.yinsiBtn.setTitle("Delete Account", for: .normal)
        accountView.yinsiBtn.setTitleColor(UIColor.init(hex: "#FC4C4D"), for: .normal)
        accountView.daikuanBtn.setTitleColor(UIColor.init(hex: "#FC4C4D"), for: .normal)
        accountView.block1 = { [weak self] in
            self?.block3?()
        }
        accountView.block2 = { [weak self] in
            self?.block4?()
        }
        return accountView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(iconImageView)
        scrollView.addSubview(iconImageView1)
        scrollView.addSubview(phoneLabel)
        scrollView.addSubview(nickLabel)
        scrollView.addSubview(iconImageView2)
        iconImageView2.addSubview(titleLabel)
        iconImageView2.addSubview(descLabel)
        scrollView.addSubview(aboutBtn)
        scrollView.addSubview(agreeView)
        scrollView.addSubview(accountView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(59.ppaix())
            make.size.equalTo(CGSize(width: 70.ppaix(), height: 70.ppaix()))
        }
        iconImageView1.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 44.ppaix(), height: 44.ppaix()))
            make.left.equalTo(iconImageView.snp.right).offset(-22.ppaix())
            make.top.equalTo(iconImageView.snp.top).offset(35.ppaix())
        }
        phoneLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView1.snp.bottom).offset(2.ppaix())
            make.height.equalTo(20.ppaix())
        }
        nickLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneLabel.snp.bottom).offset(6.ppaix())
            make.height.equalTo(25.ppaix())
        }
        iconImageView2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.ppaix(), height: 201.ppaix()))
            make.top.equalTo(nickLabel.snp.bottom).offset(10.ppaix())
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(66.ppaix())
            make.bottom.equalToSuperview().offset(-23.ppaix())
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(descLabel.snp.top).offset(-20.ppaix())
            make.height.equalTo(21.ppaix())
        }
        aboutBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.ppaix(), height: 60.ppaix()))
            make.top.equalTo(iconImageView2.snp.bottom).offset(27.ppaix())
        }
        agreeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(aboutBtn.snp.left)
            make.height.equalTo(60.ppaix())
            make.top.equalTo(aboutBtn.snp.bottom).offset(20.ppaix())
        }
        accountView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(aboutBtn.snp.left)
            make.height.equalTo(60.ppaix())
            make.top.equalTo(agreeView.snp.bottom).offset(20.ppaix())
            make.bottom.equalToSuperview().offset(-120.ppaix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradient()
    }
    
}

extension PAUserView {
    
    func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = scrollView.bounds
        gradientLayer.colors = [
            UIColor.init(hex: "#B7EC2B").cgColor,
            UIColor.init(hex: "#FCFFF2").cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.92, y: 0.08)
        gradientLayer.endPoint = CGPoint(x: 0.92, y: 0.92)
        scrollView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc func youhuiquanClick() {
        self.block5?()
    }
    
    @objc func aboutClick() {
        self.block6?()
    }
    
}
