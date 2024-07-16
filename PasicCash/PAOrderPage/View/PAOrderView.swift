//
//  PAOrderView.swift
//  PasicCash
//
//  Created by apple on 2024/7/16.
//

import UIKit

class PAOrderView: PACommonView {
    
    var block1: (() -> Void)?
    var block2: (() -> Void)?
    var block3: (() -> Void)?
    var block4: (() -> Void)?
    var block5: (() -> Void)?
    
    lazy var whiteView1: UIView = {
        let whiteView1 = UIView()
        whiteView1.layer.cornerRadius = 20.ppaix()
        whiteView1.backgroundColor = UIColor.init(hex: "#FDFFF6")
        return whiteView1
    }()
    
    lazy var whiteView2: UIView = {
        let whiteView2 = UIView()
        whiteView2.layer.cornerRadius = 20.ppaix()
        whiteView2.backgroundColor = UIColor.init(hex: "#FDFFF6")
        return whiteView2
    }()
    
    lazy var whiteView3: UIView = {
        let whiteView3 = UIView()
        whiteView3.layer.cornerRadius = 20.ppaix()
        whiteView3.backgroundColor = UIColor.init(hex: "#FDFFF6")
        return whiteView3
    }()
    
    lazy var whiteView4: UIView = {
        let whiteView4 = UIView()
        whiteView4.layer.cornerRadius = 20.ppaix()
        whiteView4.backgroundColor = UIColor.init(hex: "#FDFFF6")
        return whiteView4
    }()
    
    lazy var whiteView5: UIView = {
        let whiteView5 = UIView()
        whiteView5.layer.cornerRadius = 20.ppaix()
        whiteView5.backgroundColor = UIColor.init(hex: "#FDFFF6")
        return whiteView5
    }()
    
    lazy var icon1: UIImageView = {
        let icon1 = UIImageView()
        icon1.isUserInteractionEnabled = true
        icon1.image = UIImage(named: "Sliceoum")
        return icon1
    }()
    
    lazy var icon2: UIImageView = {
        let icon2 = UIImageView()
        icon2.isUserInteractionEnabled = true
        icon2.image = UIImage(named: "Sliceoum")
        return icon2
    }()
    
    lazy var icon3: UIImageView = {
        let icon3 = UIImageView()
        icon3.isUserInteractionEnabled = true
        icon3.image = UIImage(named: "Sliceoum")
        return icon3
    }()
    
    lazy var icon4: UIImageView = {
        let icon4 = UIImageView()
        icon4.isUserInteractionEnabled = true
        icon4.image = UIImage(named: "Sliceoum")
        return icon4
    }()
    
    lazy var icon5: UIImageView = {
        let icon5 = UIImageView()
        icon5.isUserInteractionEnabled = true
        icon5.image = UIImage(named: "Sliceoum")
        return icon5
    }()
    
    lazy var loanBtn1: UIButton = {
        let loanBtn1 = UIButton(type: .custom)
        loanBtn1.titleLabel?.font = UIFont(name: LilitaOneFont, size: 18.ppaix())
        loanBtn1.setTitleColor(UIColor.init(hex: "#1C200D"), for: .normal)
        loanBtn1.addTarget(self, action: #selector(loanBtnClick1), for: .touchUpInside)
        loanBtn1.setTitle("Loan Under Review", for: .normal)
        return loanBtn1
    }()
    
    lazy var loanBtn2: UIButton = {
        let loanBtn2 = UIButton(type: .custom)
        loanBtn2.titleLabel?.font = UIFont(name: LilitaOneFont, size: 18.ppaix())
        loanBtn2.setTitleColor(UIColor.init(hex: "#1C200D"), for: .normal)
        loanBtn2.addTarget(self, action: #selector(loanBtnClick2), for: .touchUpInside)
        loanBtn2.setTitle("Unpaid Loan Balance", for: .normal)
        return loanBtn2
    }()
    
    lazy var loanBtn3: UIButton = {
        let loanBtn3 = UIButton(type: .custom)
        loanBtn3.titleLabel?.font = UIFont(name: LilitaOneFont, size: 18.ppaix())
        loanBtn3.setTitleColor(UIColor.init(hex: "#1C200D"), for: .normal)
        loanBtn3.addTarget(self, action: #selector(loanBtnClick3), for: .touchUpInside)
        loanBtn3.setTitle("Payment Failed", for: .normal)
        return loanBtn3
    }()
    
    lazy var loanBtn4: UIButton = {
        let loanBtn4 = UIButton(type: .custom)
        loanBtn4.titleLabel?.font = UIFont(name: LilitaOneFont, size: 18.ppaix())
        loanBtn4.setTitleColor(UIColor.init(hex: "#1C200D"), for: .normal)
        loanBtn4.addTarget(self, action: #selector(loanBtnClick4), for: .touchUpInside)
        loanBtn4.setTitle("Fully Repaid", for: .normal)
        return loanBtn4
    }()
    
    lazy var loanBtn5: UIButton = {
        let loanBtn5 = UIButton(type: .custom)
        loanBtn5.titleLabel?.font = UIFont(name: LilitaOneFont, size: 20.ppaix())
        loanBtn5.setTitleColor(UIColor.init(hex: "#FC4C4D"), for: .normal)
        loanBtn5.addTarget(self, action: #selector(loanBtnClick5), for: .touchUpInside)
        loanBtn5.setTitle("Repaid Within 2 Days", for: .normal)
        return loanBtn5
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.addSubview(whiteView1)
        whiteView1.addSubview(icon1)
        whiteView1.addSubview(loanBtn1)
        
        scrollView.addSubview(whiteView2)
        whiteView2.addSubview(icon2)
        whiteView2.addSubview(loanBtn2)
        
        scrollView.addSubview(whiteView3)
        whiteView3.addSubview(icon3)
        whiteView3.addSubview(loanBtn3)
        
        scrollView.addSubview(whiteView4)
        whiteView4.addSubview(icon4)
        whiteView4.addSubview(loanBtn4)
        
        scrollView.addSubview(whiteView5)
        whiteView5.addSubview(icon5)
        whiteView5.addSubview(loanBtn5)
        
        whiteView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60.ppaix())
            make.top.equalTo(scrollView.snp.top).offset(25.ppaix())
            make.left.equalToSuperview().offset(20.ppaix())
        }
        icon1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 30.ppaix(), height: 30.ppaix()))
            make.right.equalToSuperview().offset(-17.5.ppaix())
        }
        loanBtn1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        whiteView2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60.ppaix())
            make.top.equalTo(whiteView1.snp.bottom).offset(20.ppaix())
            make.left.equalToSuperview().offset(20.ppaix())
        }
        icon2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 30.ppaix(), height: 30.ppaix()))
            make.right.equalToSuperview().offset(-17.5.ppaix())
        }
        loanBtn2.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        whiteView3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60.ppaix())
            make.top.equalTo(whiteView2.snp.bottom).offset(20.ppaix())
            make.left.equalToSuperview().offset(20.ppaix())
        }
        icon3.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 30.ppaix(), height: 30.ppaix()))
            make.right.equalToSuperview().offset(-17.5.ppaix())
        }
        loanBtn3.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        whiteView4.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60.ppaix())
            make.top.equalTo(whiteView3.snp.bottom).offset(20.ppaix())
            make.left.equalToSuperview().offset(20.ppaix())
        }
        icon4.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 30.ppaix(), height: 30.ppaix()))
            make.right.equalToSuperview().offset(-17.5.ppaix())
        }
        loanBtn4.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        whiteView5.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60.ppaix())
            make.top.equalTo(whiteView4.snp.bottom).offset(20.ppaix())
            make.left.equalToSuperview().offset(20.ppaix())
        }
        icon5.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 30.ppaix(), height: 30.ppaix()))
            make.right.equalToSuperview().offset(-17.5.ppaix())
        }
        loanBtn5.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PAOrderView {
    
    @objc func loanBtnClick1() {
        self.block1?()
    }
    
    @objc func loanBtnClick2() {
        self.block2?()
    }
    
    @objc func loanBtnClick3() {
        self.block3?()
    }
    
    @objc func loanBtnClick4() {
        self.block4?()
    }
    
    @objc func loanBtnClick5() {
        self.block5?()
    }
    
}
