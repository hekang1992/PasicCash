//
//  PANickView.swift
//  PasicCash
//
//  Created by apple on 2024/7/4.
//

import UIKit

class PANickView: UIView {
    
    var block: (() -> Void)?
    
    var block1: (() -> Void)?
    
    var block2: (() -> Void)?
    
    var block3: (() -> Void)?
    
    var block4: ((String) -> Void)?
    
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
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setImage(UIImage(named: "Group_988"), for: .normal)
        nextBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return nextBtn
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        backBtn.setImage(UIImage(named: "Slice_2"), for: .normal)
        backBtn.isHidden = true
        return backBtn
    }()
    
    lazy var skipBtn: UIButton = {
        let skipBtn = UIButton(type: .custom)
        skipBtn.contentHorizontalAlignment = .right
        skipBtn.setTitle("Skip", for: .normal)
        skipBtn.setTitleColor(UIColor.white, for: .normal)
        skipBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 20.pix())
        skipBtn.addTarget(self, action: #selector(skipBtnClick), for: .touchUpInside)
        return skipBtn
    }()
    
    lazy var imageBtn: UIButton = {
        let imageBtn = UIButton(type: .custom)
        imageBtn.setImage(UIImage(named: "Group_987"), for: .normal)
        imageBtn.addTarget(self, action: #selector(imageBtnClick), for: .touchUpInside)
        imageBtn.layer.cornerRadius = 39.pix()
        imageBtn.layer.masksToBounds = true
        return imageBtn
    }()
    
    lazy var iconImageView1: UIImageView = {
        let iconImageView1 = UIImageView()
        iconImageView1.image = UIImage(named: "Group_997")
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
        let attrString = NSMutableAttributedString(string: "Nickname", attributes: [
            .foregroundColor: UIColor.init(hex: "#D8DDCA") as Any,
            .font: UIFont(name: LilitaOneFont, size: 27.pix())!
        ])
        phoneText.textAlignment = .center
        phoneText.attributedPlaceholder = attrString
        phoneText.font = UIFont(name: LilitaOneFont, size: 27.pix())
        phoneText.textColor = UIColor.init(hex: "#1C200D")
        return phoneText
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.createLabel(font: UIFont(name: LilitaOneFont, size: 12.pix())!, textColor: UIColor.init(hex: "#FF5C5D"), textAlignment: .center)
        descLabel.text = "Nickname must be between 2 and 18 characters"
        return descLabel
    }()
    
    lazy var maleBtn: UIButton = {
        let maleBtn = UIButton(type: .custom)
        maleBtn.setTitle("Male", for: .normal)
        maleBtn.setTitleColor(UIColor.init(hex: "#1C200D"), for: .normal)
        maleBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 27.pix())
        maleBtn.addTarget(self, action: #selector(maleBtnClick(_ :)), for: .touchUpInside)
        return maleBtn
    }()
    
    lazy var femaleBtn: UIButton = {
        let femaleBtn = UIButton(type: .custom)
        femaleBtn.setTitle("Female", for: .normal)
        femaleBtn.setTitleColor(UIColor.init(hex: "#CED4BD"), for: .normal)
        femaleBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 27.pix())
        femaleBtn.addTarget(self, action: #selector(maleBtnClick(_ :)), for: .touchUpInside)
        return femaleBtn
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(hex: "#CED4BD")
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(bgImageView)
        bgImageView.addSubview(backBtn)
        bgImageView.addSubview(skipBtn)
        scrollView.addSubview(nextBtn)
        scrollView.addSubview(imageBtn)
        scrollView.addSubview(iconImageView1)
        scrollView.addSubview(iconImageView2)
        iconImageView2.addSubview(phoneText)
        scrollView.addSubview(descLabel)
        scrollView.addSubview(maleBtn)
        scrollView.addSubview(lineView)
        scrollView.addSubview(femaleBtn)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bgImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(375.pix())
        }
        backBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30.pix(), height: 30.pix()))
            make.left.equalToSuperview().offset(25.pix())
            make.top.equalToSuperview().offset(50.pix())
        }
        skipBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40.pix(), height: 23.pix()))
            make.right.equalToSuperview().offset(-25.pix())
            make.top.equalToSuperview().offset(52.5.pix())
        }
        imageBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 78.pix(), height: 78.pix()))
            make.bottom.equalTo(bgImageView.snp.bottom).offset(-47.pix())
        }
        iconImageView1.snp.makeConstraints { make in
            make.right.equalTo(imageBtn.snp.right)
            make.bottom.equalTo(imageBtn.snp.bottom)
            make.size.equalTo(CGSize(width: 28.pix(), height: 28.pix()))
        }
        iconImageView2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 313.pix(), height: 73.pix()))
            make.top.equalTo(imageBtn.snp.bottom).offset(22.pix())
        }
        phoneText.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView2.snp.bottom).offset(11.pix())
            make.height.equalTo(14.pix())
        }
        maleBtn.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(30.pix())
            make.left.equalToSuperview().offset(63.pix())
            make.size.equalTo(CGSize(width: 60.pix(), height: 32.pix()))
        }
        lineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descLabel.snp.bottom).offset(35.5.pix())
            make.size.equalTo(CGSize(width: 4.pix(), height: 20.pix()))
        }
        femaleBtn.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(30.pix())
            make.right.equalToSuperview().offset(-53.pix())
            make.size.equalTo(CGSize(width: 82.pix(), height: 32.pix()))
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(femaleBtn.snp.bottom).offset(25.pix())
            make.size.equalTo(CGSize(width: 305.pix(), height: 60.pix()))
            make.bottom.equalToSuperview().offset(-191.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PANickView: UITextFieldDelegate {
    
    @objc func btnClick() {
        self.block?()
    }
    
    @objc func backClick() {
        self.block1?()
    }
    
    @objc func skipBtnClick() {
        self.block2?()
    }
    
    @objc func imageBtnClick() {
        self.block3?()
    }
    
    @objc func maleBtnClick(_ sender: UIButton) {
        let identifier = sender == maleBtn ? "1" : "2"
        self.block4?(identifier)
        let (selectedButton, unselectedButton) = sender == maleBtn ? (maleBtn, femaleBtn) : (femaleBtn, maleBtn)
        updateButtonSelection(selectedButton: selectedButton, unselectedButton: unselectedButton)
    }
    
    private func updateButtonSelection(selectedButton: UIButton, unselectedButton: UIButton) {
        selectedButton.setTitleColor(UIColor(hex: "#1C200D"), for: .normal)
        selectedButton.titleLabel?.font = UIFont(name: LilitaOneFont, size: 27)
        unselectedButton.setTitleColor(UIColor(hex: "#CED4BD"), for: .normal)
        unselectedButton.titleLabel?.font = UIFont(name: LilitaOneFont, size: 27)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let newText = text.replacingCharacters(in: range, with: string)
            return  newText.count <= 18
        }
        return false
    }
    
}

