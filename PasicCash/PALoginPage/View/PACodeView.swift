//
//  PACodeView.swift
//  PasicCash
//
//  Created by apple on 2024/7/4.
//

import UIKit

class PACodeView: UIView {
    
    var block: (() -> Void)?
    
    var block1: (() -> Void)?
    
    var block2: (() -> Void)?
    
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
        bgImageView.isUserInteractionEnabled = true
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
        let nameLabel1 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 35.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        nameLabel1.text = "PESOIN"
        return nameLabel1
    }()
    
    lazy var nameLabel2: UILabel = {
        let nameLabel2 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 12.ppaix())!, textColor: UIColor.init(hex: "#ACAFA1"), textAlignment: .left)
        nameLabel2.text = "Simple Loans, Smart Solutions”"
        return nameLabel2
    }()
    
    lazy var iconImageView1: UIImageView = {
        let iconImageView1 = UIImageView()
        iconImageView1.isUserInteractionEnabled = true
        iconImageView1.image = UIImage(named: "Group_994")
        return iconImageView1
    }()
    
    lazy var iconImageView2: UIImageView = {
        let iconImageView2 = UIImageView()
        iconImageView2.isUserInteractionEnabled = true
        iconImageView2.image = UIImage(named: "Group_1036")
        return iconImageView2
    }()
    
    lazy var phoneText: NoCopyPasteTextField = {
        let phoneText = NoCopyPasteTextField()
        phoneText.delegate = self
        phoneText.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "123 456", attributes: [
            .foregroundColor: UIColor.init(hex: "#D8DDCA") as Any,
            .font: UIFont(name: LilitaOneFont, size: 27.ppaix())!
        ])
        phoneText.textAlignment = .center
        phoneText.attributedPlaceholder = attrString
        phoneText.font = UIFont(name: LilitaOneFont, size: 27.ppaix())
        phoneText.textColor = UIColor.init(hex: "#1C200D")
        return phoneText
    }()
    
    lazy var codeBtn: UIButton = {
        let codeBtn = UIButton(type: .custom)
        codeBtn.setTitle("Resend code", for: .normal)
        codeBtn.setTitleColor(.white, for: .normal)
        codeBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 18.ppaix())
        codeBtn.layer.cornerRadius = 15.ppaix()
        codeBtn.backgroundColor = UIColor.init(hex:"#1C200D")
        codeBtn.addTarget(self, action: #selector(codeBtnClick), for: .touchUpInside)
        codeBtn.frame = CGRectMake(0, 0, 110.ppaix(), 40.ppaix())
        return codeBtn
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitle("Login", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
//        nextBtn.isEnabled = false
        nextBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 24.ppaix())
        nextBtn.setBackgroundImage(UIImage(named: "Group_1033"), for: .normal)
        nextBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return nextBtn
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        backBtn.setImage(UIImage(named: "Slice_2"), for: .normal)
        return backBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(bgImageView)
        bgImageView.addSubview(backBtn)
        scrollView.addSubview(nameLabel1)
        scrollView.addSubview(nameLabel2)
        scrollView.addSubview(iconImageView)
        iconImageView.addSubview(nameLabel)
        scrollView.addSubview(iconImageView1)
        scrollView.addSubview(iconImageView2)
        iconImageView2.addSubview(codeBtn)
        iconImageView2.addSubview(phoneText)
        scrollView.addSubview(nextBtn)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bgImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(375.ppaix())
        }
        backBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30.ppaix(), height: 30.ppaix()))
            make.left.equalToSuperview().offset(25.ppaix())
            make.top.equalToSuperview().offset(50.ppaix())
        }
        nameLabel1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(37.5.ppaix())
            make.top.equalTo(bgImageView.snp.bottom)
            make.height.equalTo(40.ppaix())
        }
        nameLabel2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(37.5.ppaix())
            make.top.equalTo(nameLabel1.snp.bottom)
            make.height.equalTo(13.5.ppaix())
        }
        iconImageView.snp.makeConstraints { make in
            make.left.equalTo(nameLabel1.snp.right).offset(10.ppaix())
            make.centerY.equalTo(nameLabel1.snp.centerY)
            make.size.equalTo(CGSize(width: 79.ppaix(), height: 29.ppaix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconImageView2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(35.ppaix())
            make.top.equalTo(nameLabel2.snp.bottom).offset(50.ppaix())
            make.height.equalTo(68.ppaix())
        }
        codeBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10.ppaix())
            make.centerY.equalToSuperview()
            make.height.equalTo(40.ppaix())
            make.width.equalTo(110.ppaix())
        }
        phoneText.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(200.ppaix())
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView2.snp.bottom).offset(21.ppaix())
            make.size.equalTo(CGSize(width: 305.ppaix(), height: 60.ppaix()))
            make.bottom.equalToSuperview().offset(-191.ppaix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PACodeView: UITextFieldDelegate {
    
    @objc func btnClick() {
        self.block?()
    }
    
    @objc func codeBtnClick() {
        self.block1?()
    }
    
    @objc func backClick() {
        self.block2?()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let digitsOnly = newText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        if digitsOnly.count > 6 {
            return false
        }
        let formattedText = formatPhoneNumber(digitsOnly)
        textField.text = formattedText
        if let newPosition = textField.position(from: textField.beginningOfDocument, offset: formattedText.count) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
        nextBtn.isEnabled = formattedText.count == 0 ? false : true
        return false
    }
    
    func formatPhoneNumber(_ number: String) -> String {
        var result = ""
        let digits = Array(number)
        for (index, digit) in digits.enumerated() {
            if index == 3 {
                result.append(" ")
            }
            result.append(digit)
        }
        return result
    }
    
}
