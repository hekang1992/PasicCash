//
//  PALoginView.swift
//  Pesoin
//
//  Created by apple on 2024/7/4.
//

import UIKit

class PALoginView: UIView {
    
    var block: (() -> Void)?
    
    var block1: (() -> Void)?
    
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
    
    lazy var nameLabel3: UILabel = {
        let nameLabel3 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 27.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        nameLabel3.text = "+63"
        return nameLabel3
    }()
    
    lazy var iconImageView2: UIImageView = {
        let iconImageView2 = UIImageView()
        iconImageView2.isUserInteractionEnabled = true
        iconImageView2.image = UIImage(named: "Group_995")
        return iconImageView2
    }()
    
    lazy var phoneText: NoCopyPasteTextField = {
        let phoneText = NoCopyPasteTextField()
        phoneText.delegate = self
        phoneText.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "912 888 8888", attributes: [
            .foregroundColor: UIColor.init(hex: "#D8DDCA") as Any,
            .font: UIFont(name: LilitaOneFont, size: 27.ppaix())!
        ])
        phoneText.attributedPlaceholder = attrString
        phoneText.rightView = rightView
        phoneText.rightViewMode = .always
        phoneText.leftView = leftView
        phoneText.leftViewMode = .always
        phoneText.font = UIFont(name: LilitaOneFont, size: 27.ppaix())
        phoneText.textColor = UIColor.init(hex: "#1C200D")
        return phoneText
    }()
    
    lazy var leftView: UIView = {
        let leftView = UIView(frame: CGRectMake(0, 0, 20.ppaix(), 20.ppaix()))
        return leftView
    }()
    
    lazy var rightView: UIView = {
        let rightImageView = UIImageView(frame: CGRectMake(0, 0, 40.ppaix(), 40.ppaix()))
        rightImageView.image = UIImage(named: "Group_20")
        rightImageView.contentMode = .left
        rightImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(delTapped))
        rightImageView.addGestureRecognizer(tapGesture)
        let rightView = UIView(frame: CGRectMake(0, 0, 40.ppaix(), 40.ppaix()))
        rightView.addSubview(rightImageView)
        rightView.isHidden = true
        return rightView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitle("Login", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.isEnabled = false
        nextBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 24.ppaix())
        nextBtn.setBackgroundImage(UIImage(named: "Group_1033"), for: .normal)
        nextBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return nextBtn
    }()
    
    lazy var visBtn: UIButton = {
        let visBtn = UIButton(type: .custom)
        visBtn.setTitle("Visitor status access.", for: .normal)
        visBtn.setTitleColor(UIColor.init(hex: "#CED4BD"), for: .normal)
        visBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 16.ppaix())
        visBtn.addTarget(self, action: #selector(visBtnClick), for: .touchUpInside)
        return visBtn
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Slice_1")
        return icon
    }()
    
    lazy var agreeBtn: UIButton = {
        let agreeBtn = UIButton(type: .custom)
        agreeBtn.setImage(UIImage(named: "Group_1035"), for: .normal)
        agreeBtn.addTarget(self, action: #selector(agreeBtnClick(_ :)), for: .touchUpInside)
        return agreeBtn
    }()
    
    private lazy var agreeLabel: UILabel = {
        let agreeLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 12.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        let attributedText = NSMutableAttributedString(string: "By clicking 'Login', you agree to the ")
        let userAgreement = NSMutableAttributedString(string: "USER AGREEMENT", attributes: [
            .foregroundColor: UIColor.init(hex: "#C2EF44"),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        attributedText.append(userAgreement)
        agreeLabel.attributedText = attributedText
        agreeLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userAgreementTapped))
        agreeLabel.addGestureRecognizer(tapGesture)
        return agreeLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(bgImageView)
        scrollView.addSubview(nameLabel1)
        scrollView.addSubview(nameLabel2)
        scrollView.addSubview(iconImageView)
        iconImageView.addSubview(nameLabel)
        scrollView.addSubview(iconImageView1)
        scrollView.addSubview(nameLabel3)
        scrollView.addSubview(iconImageView2)
        iconImageView2.addSubview(phoneText)
        scrollView.addSubview(nextBtn)
        scrollView.addSubview(visBtn)
        scrollView.addSubview(icon)
        scrollView.addSubview(agreeBtn)
        scrollView.addSubview(agreeLabel)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bgImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(375.ppaix())
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
        nameLabel3.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35.ppaix())
            make.top.equalTo(nameLabel2.snp.bottom).offset(64.ppaix())
            make.height.equalTo(31.ppaix())
        }
        iconImageView2.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel3.snp.centerY)
            make.left.equalTo(nameLabel3.snp.right).offset(10.ppaix())
            make.right.equalToSuperview().offset(-35.ppaix())
            make.height.equalTo(68.ppaix())
        }
        phoneText.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView2.snp.bottom).offset(21.ppaix())
            make.size.equalTo(CGSize(width: 305.ppaix(), height: 60.ppaix()))
        }
        visBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nextBtn.snp.bottom).offset(21.ppaix())
            make.size.equalTo(CGSize(width: 150.ppaix(), height: 19.ppaix()))
        }
        icon.snp.makeConstraints { make in
            make.centerY.equalTo(visBtn.snp.centerY)
            make.left.equalTo(visBtn.snp.right).offset(5.ppaix())
            make.size.equalTo(CGSize(width: 17.ppaix(), height: 17.ppaix()))
        }
        agreeBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30.ppaix())
            make.top.equalTo(visBtn.snp.bottom).offset(94.ppaix())
            make.size.equalTo(CGSize(width: 28.ppaix(), height: 28.ppaix()))
            make.bottom.equalToSuperview().offset(-45.ppaix())
        }
        agreeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(agreeBtn.snp.centerY)
            make.left.equalTo(agreeBtn.snp.right)
            make.height.equalTo(14.ppaix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PALoginView: UITextFieldDelegate {
    
    @objc func btnClick() {
        self.block?()
    }
    
    @objc func visBtnClick() {
        self.block1?()
    }
    
    @objc func delTapped() {
        phoneText.text = ""
        rightView.isHidden = true
    }
    
    @objc func agreeBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            nextBtn.isEnabled = true
            sender.setImage(UIImage(named: "Group_1034"), for: .normal)
        }else {
            nextBtn.isEnabled = false
            sender.setImage(UIImage(named: "Group_1035"), for: .normal)
        }
    }
    
    @objc func userAgreementTapped() {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let digitsOnly = newText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        if digitsOnly.count > 10 {
            return false
        }
        let formattedText = formatPhoneNumber(digitsOnly)
        textField.text = formattedText
        if let newPosition = textField.position(from: textField.beginningOfDocument, offset: formattedText.count) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
        rightView.isHidden = formattedText.count == 0 ? true : false
        return false
    }
    
    func formatPhoneNumber(_ number: String) -> String {
        var result = ""
        let digits = Array(number)
        for (index, digit) in digits.enumerated() {
            if index == 3 || index == 6 {
                result.append(" ")
            }
            result.append(digit)
        }
        return result
    }
    
}
