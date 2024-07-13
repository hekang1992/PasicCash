//
//  PABankView.swift
//  PasicCash
//
//  Created by apple on 2024/7/11.
//

import UIKit

class PABankView: PACommonView {
    
    var block1: (() -> Void)?
    
    var block2: (() -> Void)?

    lazy var bankImageView: UIImageView = {
        let bankImageView = UIImageView()
        bankImageView.image = UIImage(named: "Group_1029")
        return bankImageView
    }()
    
    lazy var label1: UILabel = {
        let label1 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .center)
        label1.text = "Enter card number to add"
        return label1
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
        let attrString = NSMutableAttributedString(string: "Card number", attributes: [
            .foregroundColor: UIColor.init(hex: "#CED4BD") as Any,
            .font: UIFont(name: LilitaOneFont, size: 22.ppaix())!
        ])
        phoneText.attributedPlaceholder = attrString
        phoneText.rightView = rightView
        phoneText.rightViewMode = .always
        phoneText.leftView = leftView
        phoneText.leftViewMode = .always
        phoneText.font = UIFont(name: LilitaOneFont, size: 22.ppaix())
        phoneText.textColor = UIColor.init(hex: "#1C200D")
        phoneText.textAlignment = .center
        return phoneText
    }()
    
    lazy var leftView: UIView = {
        let leftView = UIView(frame: CGRectMake(0, 0, 40.ppaix(), 40.ppaix()))
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
    
    lazy var label2: UILabel = {
        let label2 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 12.ppaix())!, textColor: UIColor.init(hex: "#FF5C5D"), textAlignment: .center)
        label2.text = "Please confirm that the card number is correct"
        return label2
    }()
    
    lazy var label3: UILabel = {
        let label3 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .center)
        label3.text = "Choose a bank"
        return label3
    }()
    
    lazy var bankBtn: UIButton = {
        let bankBtn = UIButton(type: .custom)
        bankBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 18.ppaix())
        bankBtn.setTitleColor(UIColor.init(hex: "#0CE094"), for: .normal)
        bankBtn.adjustsImageWhenHighlighted = false
        bankBtn.setBackgroundImage(UIImage(named: "Slice_10"), for: .normal)
        bankBtn.setTitle("Please select your bank", for: .normal)
        bankBtn.addTarget(self, action: #selector(bankClick), for: .touchUpInside)
        return bankBtn
    }()
    
    lazy var icon7: UIImageView = {
        let icon7 = UIImageView()
        icon7.image = UIImage(named: "Group_1059")
        return icon7
    }()
    
    lazy var descLabel1: UILabel = {
        let descLabel1 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 9.ppaix())!, textColor: UIColor.init(hex: "#8D917F"), textAlignment: .left)
        descLabel1.text = "Your data is used exclusively for approval, and PasicCash guarantees the protection of your privacy."
        descLabel1.numberOfLines = 0
        return descLabel1
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 24.ppaix())
        nextBtn.adjustsImageWhenHighlighted = false
        nextBtn.setBackgroundImage(UIImage(named: "Group_1095"), for: .normal)
        let fullString = "Complete 3/3"
        let attributedString = NSMutableAttributedString(string: fullString)
        let color = UIColor.init(hex: "#FEE610")
        if let range = fullString.range(of: "Complete") {
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
        scrollView.addSubview(bankImageView)
        scrollView.addSubview(label1)
        scrollView.addSubview(iconImageView2)
        iconImageView2.addSubview(phoneText)
        scrollView.addSubview(label2)
        scrollView.addSubview(label3)
        scrollView.addSubview(bankBtn)
        scrollView.addSubview(icon7)
        scrollView.addSubview(descLabel1)
        scrollView.addSubview(nextBtn)
        bankImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24.ppaix())
            make.size.equalTo(CGSize(width: 265.ppaix(), height: 166.ppaix()))
        }
        label1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bankImageView.snp.bottom).offset(30.ppaix())
            make.height.equalTo(21.ppaix())
        }
        iconImageView2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label1.snp.bottom).offset(15.ppaix())
            make.size.equalTo(CGSize(width: 325.ppaix(), height: 68.ppaix()))
        }
        phoneText.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneText.snp.bottom).offset(11.ppaix())
            make.height.equalTo(14.ppaix())
        }
        label3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label2.snp.bottom).offset(20.ppaix())
            make.height.equalTo(21.ppaix())
        }
        bankBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label3.snp.bottom).offset(15.ppaix())
            make.height.equalTo(60.ppaix())
            make.left.equalToSuperview().offset(25.ppaix())
            
        }
        icon7.snp.makeConstraints { make in
            make.top.equalTo(bankBtn.snp.bottom).offset(159.ppaix())
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

extension PABankView: UITextFieldDelegate {
    
    @objc func delTapped() {
        phoneText.text = ""
        rightView.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        rightView.isHidden = newText.count == 0 ? true : false
        return newText.count <= 18
    }
    
    @objc func bankClick() {
        self.block1?()
    }
    
    @objc func photoClick() {
        self.block2?()
    }
}
