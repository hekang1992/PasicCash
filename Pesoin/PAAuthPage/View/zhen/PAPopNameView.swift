//
//  PAPopNameView.swift
//  Pesoin
//
//  Created by apple on 2024/7/14.
//

import UIKit

class PAPopNameView: UIView {
    
    var block: (() -> Void)?
    
    var block1: (() -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hex: "#F4FDDA")
        bgView.layer.cornerRadius = 20.ppaix()
        return bgView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var nameLabel1: UILabel = {
        let nameLabel1 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        nameLabel1.text = "Name:"
        return nameLabel1
    }()
    
    lazy var bgView1: UIView = {
        let bgView1 = UIView()
        bgView1.backgroundColor = UIColor.init(hex: "#FDFFF6")
        bgView1.layer.cornerRadius = 15.ppaix()
        bgView1.layer.borderWidth = 2.ppaix()
        bgView1.layer.borderColor = UIColor.init(hex: "#C6F14D").cgColor
        return bgView1
    }()
    
    lazy var textFi1: NoCopyPasteTextField = {
        let textFi1 = NoCopyPasteTextField()
        textFi1.font = UIFont(name: LilitaOneFont, size: 20.ppaix())
        textFi1.textColor = UIColor.init(hex: "#719F60")
        textFi1.placeholder = "Enter your name"
        return textFi1
    }()
    
    lazy var icon1: UIImageView = {
        let icon1 = UIImageView()
        icon1.image = UIImage(named: "Slicearrow")
        return icon1
    }()
    
    lazy var icon2: UIImageView = {
        let icon2 = UIImageView()
        icon2.image = UIImage(named: "Slicearrow")
        return icon2
    }()
    
    lazy var icon3: UIImageView = {
        let icon3 = UIImageView()
        icon3.image = UIImage(named: "Slicearrow")
        return icon3
    }()
    
    lazy var nameLabel2: UILabel = {
        let nameLabel2 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        nameLabel2.text = "Number:"
        return nameLabel2
    }()
    
    lazy var bgView2: UIView = {
        let bgView2 = UIView()
        bgView2.backgroundColor = UIColor.init(hex: "#FDFFF6")
        bgView2.layer.cornerRadius = 15.ppaix()
        bgView2.layer.borderWidth = 2.ppaix()
        bgView2.layer.borderColor = UIColor.init(hex: "#C6F14D").cgColor
        return bgView2
    }()
    
    lazy var textFi2: NoCopyPasteTextField = {
        let textFi2 = NoCopyPasteTextField()
        textFi2.font = UIFont(name: LilitaOneFont, size: 20.ppaix())
        textFi2.textColor = UIColor.init(hex: "#719F60")
        textFi2.placeholder = "Enter your number"
        return textFi2
    }()
    
    lazy var nameLabel3: UILabel = {
        let nameLabel3 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        nameLabel3.text = "Date of Birth:"
        return nameLabel3
    }()
    
    lazy var bgView3: UIView = {
        let bgView3 = UIView()
        bgView3.backgroundColor = UIColor.init(hex: "#FDFFF6")
        bgView3.layer.cornerRadius = 15.ppaix()
        bgView3.layer.borderWidth = 2.ppaix()
        bgView3.layer.borderColor = UIColor.init(hex: "#C6F14D").cgColor
        return bgView3
    }()
    
    lazy var dateBtn: UIButton = {
        let dateBtn = UIButton(type: .custom)
        dateBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 20.ppaix())
        dateBtn.setTitleColor(UIColor.init(hex: "#719F60"), for: .normal)
        dateBtn.addTarget(self, action: #selector(dateBtnClick), for: .touchUpInside)
        dateBtn.contentHorizontalAlignment = .left
        return dateBtn
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
        bgView.addSubview(scrollView)
        scrollView.addSubview(nameLabel1)
        scrollView.addSubview(bgView1)
        bgView1.addSubview(textFi1)
        bgView1.addSubview(icon1)
        scrollView.addSubview(nameLabel2)
        scrollView.addSubview(bgView2)
        bgView2.addSubview(textFi2)
        bgView2.addSubview(icon2)
        scrollView.addSubview(nameLabel3)
        scrollView.addSubview(bgView3)
        bgView3.addSubview(dateBtn)
        bgView3.addSubview(icon3)
        scrollView.addSubview(confirmBtn)
        bgView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(500.ppaix())
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nameLabel1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35.ppaix())
            make.top.equalToSuperview().offset(35.ppaix())
            make.height.equalTo(21.ppaix())
        }
        bgView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60.ppaix())
            make.top.equalTo(nameLabel1.snp.bottom).offset(15.ppaix())
            make.left.equalToSuperview().offset(35.ppaix())
        }
        nameLabel2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35.ppaix())
            make.top.equalTo(bgView1.snp.bottom).offset(20.ppaix())
            make.height.equalTo(21.ppaix())
        }
        bgView2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60.ppaix())
            make.top.equalTo(nameLabel2.snp.bottom).offset(15.ppaix())
            make.left.equalToSuperview().offset(35.ppaix())
        }
        nameLabel3.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35.ppaix())
            make.top.equalTo(bgView2.snp.bottom).offset(20.ppaix())
            make.height.equalTo(21.ppaix())
        }
        bgView3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60.ppaix())
            make.top.equalTo(nameLabel3.snp.bottom).offset(15.ppaix())
            make.left.equalToSuperview().offset(35.ppaix())
        }
        confirmBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgView3.snp.bottom).offset(30.ppaix())
            make.size.equalTo(CGSize(width: 305.ppaix(), height: 60.ppaix()))
            make.bottom.equalToSuperview().offset(-35.ppaix())
        }
        textFi1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.ppaix())
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-50.ppaix())
        }
        textFi2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.ppaix())
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-50.ppaix())
        }
        icon1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15.ppaix())
            make.size.equalTo(CGSize(width: 30.ppaix(), height: 30.ppaix()))
        }
        icon2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15.ppaix())
            make.size.equalTo(CGSize(width: 30.ppaix(), height: 30.ppaix()))
        }
        icon3.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15.ppaix())
            make.size.equalTo(CGSize(width: 30.ppaix(), height: 30.ppaix()))
        }
        dateBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20.ppaix(), bottom: 0, right: 0))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PAPopNameView {
    
    @objc func confirmBtnClick() {
        self.block?()
    }
    
    @objc func dateBtnClick() {
        self.block1?()
    }
    
}
