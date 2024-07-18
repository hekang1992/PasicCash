//
//  PABorrowView.swift
//  Pesoin
//
//  Created by apple on 2024/7/3.
//

import UIKit

class PABorrowView: UIView {
    
    var block: (() -> Void)?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .white
        return scrollView
    }()

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.image = UIImage(named: "pasmilebg")
        return bgImageView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "Group_992")
        return iconImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 13.ppaix())!, textColor: UIColor.init(hex: "#293014"), textAlignment: .center)
        nameLabel.text = "Pesoin"
        return nameLabel
    }()
    
    lazy var nameLabel1: UILabel = {
        let nameLabel1 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 28.ppaix())!, textColor: UIColor.init(hex: "#293014"), textAlignment: .left)
        nameLabel1.numberOfLines = 0
        nameLabel1.text = "How Much Would You Like to Borrow?"
        return nameLabel1
    }()
    
    lazy var nameLabel2: UILabel = {
        let nameLabel2 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 12.ppaix())!, textColor: UIColor.init(hex: "#ACAFA1"), textAlignment: .left)
        nameLabel2.numberOfLines = 0
        nameLabel2.text = "We are here to assist you with your financial needs. Please let us know the amount you wish to borrow so we can proceed with your application!"
        return nameLabel2
    }()
    
    lazy var iconImageView1: UIImageView = {
        let iconImageView1 = UIImageView()
        iconImageView1.isUserInteractionEnabled = true
        iconImageView1.image = UIImage(named: "Group_994")
        return iconImageView1
    }()
    
    lazy var nameLabel3: UILabel = {
        let nameLabel3 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 32.ppaix())!, textColor: UIColor.init(hex: "#CED4BD"), textAlignment: .center)
        nameLabel3.text = "50,000 Max"
        return nameLabel3
    }()
    
    lazy var nameLabel4: UILabel = {
        let nameLabel4 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 12.ppaix())!, textColor: UIColor.init(hex: "#CED4BD"), textAlignment: .center)
        nameLabel4.text = "2,000(Min)"
        return nameLabel4
    }()
    
    lazy var nameLabel5: UILabel = {
        let nameLabel5 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 12.ppaix())!, textColor: UIColor.init(hex: "#CED4BD"), textAlignment: .center)
        nameLabel5.text = "50,000(Max)"
        return nameLabel5
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 2000
        slider.maximumValue = 50000
        slider.value = 25000
        slider.isContinuous = true
        slider.tintColor = UIColor.init(hex: "#C4F13E")
        slider.setThumbImage(UIImage(named: "Group_990.png"), for: .normal)
        return slider
    }()
    
    lazy var nameLabel6: UILabel = {
        let nameLabel6 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 10.ppaix())!, textColor: UIColor.init(hex: "#D9D9D9"), textAlignment: .center)
        nameLabel6.text = "The actual loan amount is subject to system review."
        return nameLabel6
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setImage(UIImage(named: "Group_988"), for: .normal)
        nextBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return nextBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(bgImageView)
        scrollView.addSubview(iconImageView)
        iconImageView.addSubview(nameLabel)
        scrollView.addSubview(nameLabel1)
        scrollView.addSubview(nameLabel2)
        scrollView.addSubview(iconImageView1)
        iconImageView1.addSubview(nameLabel3)
        scrollView.addSubview(nameLabel4)
        scrollView.addSubview(nameLabel5)
        scrollView.addSubview(slider)
        scrollView.addSubview(nameLabel6)
        scrollView.addSubview(nextBtn)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bgImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(375.ppaix())
        }
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35.ppaix())
            make.top.equalToSuperview().offset(282.ppaix())
            make.size.equalTo(CGSize(width: 79.ppaix(), height: 29.ppaix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nameLabel1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom).offset(10.ppaix())
            make.left.equalTo(iconImageView.snp.left)
            make.height.equalTo(66.ppaix())
        }
        nameLabel2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel1.snp.bottom).offset(15.ppaix())
            make.left.equalTo(iconImageView.snp.left)
            make.height.equalTo(66.ppaix())
        }
        iconImageView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel2.snp.bottom).offset(46.ppaix())
            make.left.equalTo(iconImageView.snp.left)
            make.height.equalTo(72.ppaix())
        }
        nameLabel3.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nameLabel4.snp.makeConstraints { make in
            make.left.equalTo(iconImageView1.snp.left)
            make.top.equalTo(iconImageView1.snp.bottom).offset(47.ppaix())
            make.height.equalTo(14.ppaix())
        }
        nameLabel5.snp.makeConstraints { make in
            make.right.equalTo(iconImageView1.snp.right)
            make.top.equalTo(iconImageView1.snp.bottom).offset(47.ppaix())
            make.height.equalTo(14.ppaix())
        }
        slider.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView1.snp.bottom).offset(14.ppaix())
            make.left.equalTo(iconImageView.snp.left)
            make.height.equalTo(40.ppaix())
        }
        nameLabel6.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(slider.snp.bottom).offset(65.ppaix())
            make.height.equalTo(12.ppaix())
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel6.snp.bottom).offset(10.ppaix())
            make.size.equalTo(CGSize(width: 305.ppaix(), height: 60.ppaix()))
            make.bottom.equalToSuperview().offset(-45.ppaix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PABorrowView {
    
    @objc func btnClick() {
        self.block?()
    }
}
