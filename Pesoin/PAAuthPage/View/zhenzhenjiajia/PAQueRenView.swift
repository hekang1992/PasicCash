//
//  PAQueRenView.swift
//  Pesoin
//
//  Created by apple on 2024/7/12.
//

import UIKit
import BRPickerView

class PAQueRenView: PACommonView {
    
    var array: [[twitchModel]]?
    
    var saveBlock: (() -> Void)?
    
    var block1: ((String) -> Void)?
    
    var loanPurBlock: ((UIButton, [BRProvinceModel]) -> Void)?
    
    var loanPurBlock1: ((UIButton, [BRProvinceModel]) -> Void)?
    
    var loanPurBlock2: ((UIButton, [BRProvinceModel]) -> Void)?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.ppaix()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(qurenCell1.self, forCellReuseIdentifier: "qurenCell1")
        tableView.register(qurenCell2.self, forCellReuseIdentifier: "qurenCell2")
        tableView.register(qurenCell3.self, forCellReuseIdentifier: "qurenCell3")
        tableView.register(qurenCell4.self, forCellReuseIdentifier: "qurenCell4")
        return tableView
    }()
    
    lazy var agreeBtn: UIButton = {
        let agreeBtn = UIButton(type: .custom)
        agreeBtn.setImage(UIImage(named: "Group_1035"), for: .normal)
        agreeBtn.addTarget(self, action: #selector(agreeBtnClick(_ :)), for: .touchUpInside)
        return agreeBtn
    }()
    
    private lazy var agreeLabel: UILabel = {
        let agreeLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 12.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        let attributedText = NSMutableAttributedString(string: "I have read and agreed to the ")
        let userAgreement = NSMutableAttributedString(string: "Loan Agreement.", attributes: [
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
        nextBtn.setTitle("Next", for: .normal)
        nextBtn.isEnabled = false
        nextBtn.addTarget(self, action: #selector(nextClick), for: .touchUpInside)
        return nextBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(scrollView.snp.top)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PAQueRenView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 220.ppaix()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let bgView = UIView()
        bgView.addSubview(agreeBtn)
        bgView.addSubview(agreeLabel)
        bgView.addSubview(icon7)
        bgView.addSubview(descLabel1)
        bgView.addSubview(nextBtn)
        agreeBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30.ppaix())
            make.top.equalToSuperview().offset(15.ppaix())
            make.size.equalTo(CGSize(width: 28.ppaix(), height: 28.ppaix()))
        }
        agreeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(agreeBtn.snp.centerY)
            make.left.equalTo(agreeBtn.snp.right)
            make.height.equalTo(14.ppaix())
        }
        icon7.snp.makeConstraints { make in
            make.top.equalTo(agreeBtn.snp.bottom).offset(56.ppaix())
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
        }
        return bgView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = array?[indexPath.row][0]
        if model?.goneup == "amount" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "qurenCell1") as? qurenCell1 {
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                cell.model = model
                cell.block = { [weak self] String in
                    self?.block1?(cell.monetTextField.text ?? "")
                }
                return cell
            }
        }else if model?.goneup == "reminder" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "qurenCell2") as? qurenCell2 {
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                cell.model = array?[indexPath.row]
                cell.block = { [weak self] btn, array in
                    self?.loanPurBlock?(btn, array)
                }
                return cell
            }
        }else if model?.goneup == "voucher" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "qurenCell3") as? qurenCell3 {
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                cell.model = array?[indexPath.row]
                cell.block = { [weak self] btn, array in
                    self?.loanPurBlock1?(btn, array)
                }
                cell.block1 = { [weak self] btn, array in
                    self?.loanPurBlock2?(btn, array)
                }
                return cell
            }
        }else if model?.goneup == "companyName" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "qurenCell4") as? qurenCell4 {
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                cell.model = array?[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
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
    
    @objc func nextClick() {
        self.saveBlock?()
    }
}

class qurenCell1: UITableViewCell, UITextFieldDelegate {
    
    var lastBtn: UIButton?
    
    var block: ((String) -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = UIImage(named: "Group_qu1")
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var monetTextField: NoCopyPasteTextField = {
        let monetTextField = NoCopyPasteTextField()
        monetTextField.keyboardType = .numberPad
        monetTextField.delegate = self
        monetTextField.font = UIFont(name: LilitaOneFont, size: 65.ppaix())
        return monetTextField
    }()
    
    lazy var editImageView: UIImageView = {
        let editImageView = UIImageView()
        editImageView.image = UIImage(named: "Group_1042")
        return editImageView
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(hex: "#1C200D")
        return lineView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(monetTextField)
        bgImageView.addSubview(editImageView)
        bgImageView.addSubview(lineView)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.ppaix(), height: 335.ppaix()))
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(45.5.ppaix())
            make.top.equalToSuperview().offset(36.5.ppaix())
            make.height.equalTo(20.5.ppaix())
        }
        monetTextField.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(nameLabel.snp.bottom).offset(15.ppaix())
            make.size.equalTo(CGSize(width: 237.ppaix(), height: 80.ppaix()))
        }
        editImageView.snp.makeConstraints { make in
            make.left.equalTo(monetTextField.snp.right).offset(15.ppaix())
            make.bottom.equalTo(monetTextField.snp.bottom).offset(-15.5.ppaix())
            make.size.equalTo(CGSize(width: 19.ppaix(), height: 19.ppaix()))
        }
        lineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(45.5.ppaix())
            make.height.equalTo(2.ppaix())
            make.top.equalTo(monetTextField.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: twitchModel? {
        didSet {
            guard let model = model else { return }
            for subview in bgImageView.subviews {
                if subview is UIButton {
                    subview.removeFromSuperview()
                }
            }
            let buttonHeight: CGFloat = 30.ppaix()
            let buttonWidth: CGFloat = 70.ppaix()
            let padding: CGFloat = 10
            let startY: CGFloat = 189.ppaix()
            var xPosition = 45.5.ppaix()
            nameLabel.text = model.forcovering
            monetTextField.text = model.pester
            self.block?(model.pester ?? "")
            if let birds = model.birds {
                for (index, option) in birds.enumerated() {
                    let radioButton = UIButton(type: .custom)
                    radioButton.titleLabel?.font = UIFont(name: LilitaOneFont, size: 16.ppaix())
                    radioButton.setTitleColor(UIColor.init(hex: "#0CE094"), for: .normal)
                    radioButton.layer.cornerRadius = 10.ppaix()
                    radioButton.layer.borderWidth = 2.ppaix()
                    radioButton.layer.borderColor = UIColor.init(hex: "#0CE094").cgColor
                    radioButton.backgroundColor = UIColor.clear
                    radioButton.setTitle(option.hoses, for: .normal)
                    if index == 3 {
                        radioButton.frame = CGRect(x: xPosition, y: startY, width: 45.ppaix(), height: 30.ppaix())
                    }else {
                        radioButton.frame = CGRect(x: xPosition, y: startY, width: buttonWidth, height: buttonHeight)
                    }
                    bgImageView.addSubview(radioButton)
                    radioButton.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
                    xPosition += buttonWidth + padding
                }
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if updatedText.isEmpty {
            return true
        } else if updatedText.count > 5 {
            return false
        } else if let number = Int(updatedText), number > 50000 {
            textField.text = "50000"
            return false
        }
        return true
    }
    
    @objc private func radioButtonTapped(_ sender: UIButton) {
        if sender == lastBtn {
            sender.isSelected = !sender.isSelected
            if !sender.isSelected {
                sender.setTitleColor(UIColor.init(hex: "#0CE094"), for: .normal)
                sender.backgroundColor = UIColor.clear
                lastBtn = nil
            }
        } else {
            lastBtn?.isSelected = false
            lastBtn?.setTitleColor(UIColor.init(hex: "#0CE094"), for: .normal)
            lastBtn?.backgroundColor = UIColor.clear
            
            sender.isSelected = true
            sender.setTitleColor(.white, for: .normal)
            sender.backgroundColor = UIColor.init(hex: "#0CE094")
            let str = sender.titleLabel?.text
            if str == "All" {
                monetTextField.text = "50000"
            }else {
                let cleanedAmountString = str?.replacingOccurrences(of: ",", with: "")
                monetTextField.text = cleanedAmountString
            }
            lastBtn = sender
        }
    }
    
}

class qurenCell2: UITableViewCell {
    
    var block: ((UIButton, [BRProvinceModel]) -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hex: "#FDFFF6")
        bgView.layer.cornerRadius = 20.ppaix()
        return bgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var nameLabel1: UILabel = {
        let nameLabel1 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        return nameLabel1
    }()
    
    lazy var switchIcon: UISwitch = {
        let switchIcon = UISwitch()
        switchIcon.isOn = true
        switchIcon.onTintColor = UIColor.init(hex: "#0CE094")
        switchIcon.tintColor = UIColor.gray
        return switchIcon
    }()
    
    lazy var grView: UIView = {
        let grView = UIView()
        grView.layer.cornerRadius = 10.ppaix()
        grView.backgroundColor = UIColor.init(hex: "#EFF5E7")
        return grView
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Group_1049")
        return icon
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.addTarget(self, action: #selector(clickBtnClick(_ :)), for: .touchUpInside)
        return clickBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(nameLabel1)
        bgView.addSubview(switchIcon)
        bgView.addSubview(grView)
        grView.addSubview(icon)
        grView.addSubview(clickBtn)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(25.5.ppaix())
            make.top.equalToSuperview()
            make.height.equalTo(136.ppaix())
            make.bottom.equalToSuperview().offset(-14.ppaix())
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.ppaix())
            make.top.equalToSuperview().offset(20.ppaix())
            make.height.equalTo(20.5.ppaix())
        }
        nameLabel1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.ppaix())
            make.top.equalTo(nameLabel.snp.bottom).offset(20.ppaix())
            make.height.equalTo(20.5.ppaix())
        }
        switchIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.ppaix())
            make.right.equalToSuperview().offset(-20.ppaix())
            make.size.equalTo(CGSize(width: 45.ppaix(), height: 20.ppaix()))
        }
        grView.snp.makeConstraints { make in
            make.left.equalTo(nameLabel1.snp.left)
            make.right.equalToSuperview().offset(-20.ppaix())
            make.top.equalTo(nameLabel1.snp.bottom).offset(5.ppaix())
            make.height.equalTo(30.ppaix())
        }
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 8.ppaix(), height: 12.ppaix()))
            make.right.equalToSuperview().offset(-15.ppaix())
        }
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if let bankArray = model?[1].birds {
            let loanPArray = yijiModel.getyijiArr(dataSourceArr: bankArray)
            self.block?(sender, loanPArray)
        }
    }
    
    var model: [twitchModel]? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model[0].forcovering
            nameLabel1.text = model[1].forcovering
        }
    }
}

class qurenCell3: UITableViewCell {
    
    var block: ((UIButton, [BRProvinceModel]) -> Void)?
    
    var block1: ((UIButton, [BRProvinceModel]) -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hex: "#FDFFF6")
        bgView.layer.cornerRadius = 20.ppaix()
        return bgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var grView: UIView = {
        let grView = UIView()
        grView.layer.cornerRadius = 10.ppaix()
        grView.backgroundColor = UIColor.init(hex: "#EFF5E7")
        return grView
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Group_1049")
        return icon
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.addTarget(self, action: #selector(clickBtnClick(_ :)), for: .touchUpInside)
        clickBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 16.ppaix())
        clickBtn.setTitleColor(UIColor.init(hex: "#0CE094"), for: .normal)
        return clickBtn
    }()
    
    lazy var nameLabel1: UILabel = {
        let nameLabel1 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        return nameLabel1
    }()
    
    lazy var grView1: UIView = {
        let grView1 = UIView()
        grView1.layer.cornerRadius = 10.ppaix()
        grView1.backgroundColor = UIColor.init(hex: "#EFF5E7")
        return grView1
    }()
    
    lazy var icon1: UIImageView = {
        let grView1 = UIImageView()
        grView1.image = UIImage(named: "Group_1049")
        return grView1
    }()
    
    lazy var clickBtn1: UIButton = {
        let clickBtn1 = UIButton(type: .custom)
        clickBtn1.addTarget(self, action: #selector(clickBtnClick1(_ :)), for: .touchUpInside)
        return clickBtn1
    }()
    
    lazy var nameLabel2: UILabel = {
        let nameLabel2 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        return nameLabel2
    }()
    
    lazy var grView2: UIView = {
        let grView2 = UIView()
        grView2.layer.cornerRadius = 10.ppaix()
        grView2.backgroundColor = UIColor.init(hex: "#EFF5E7")
        return grView2
    }()
    
    lazy var clickBtn2: UIButton = {
        let clickBtn2 = UIButton(type: .custom)
        clickBtn2.titleLabel?.font = UIFont(name: LilitaOneFont, size: 16.ppaix())
        clickBtn2.setTitleColor(UIColor.init(hex: "#0CE094"), for: .normal)
        return clickBtn2
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(grView)
        grView.addSubview(icon)
        grView.addSubview(clickBtn)
        bgView.addSubview(nameLabel1)
        bgView.addSubview(grView1)
        grView1.addSubview(icon1)
        grView1.addSubview(clickBtn1)
        bgView.addSubview(nameLabel2)
        bgView.addSubview(grView2)
        grView2.addSubview(clickBtn2)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(25.5.ppaix())
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-14.ppaix())
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.ppaix())
            make.top.equalToSuperview().offset(20.ppaix())
            make.height.equalTo(20.5.ppaix())
        }
        grView.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.right.equalToSuperview().offset(-20.ppaix())
            make.top.equalTo(nameLabel.snp.bottom).offset(5.ppaix())
            make.height.equalTo(30.ppaix())
        }
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 8.ppaix(), height: 12.ppaix()))
            make.right.equalToSuperview().offset(-15.ppaix())
        }
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nameLabel1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.ppaix())
            make.top.equalTo(grView.snp.bottom).offset(20.ppaix())
            make.height.equalTo(20.5.ppaix())
        }
        grView1.snp.makeConstraints { make in
            make.left.equalTo(nameLabel1.snp.left)
            make.right.equalToSuperview().offset(-20.ppaix())
            make.top.equalTo(nameLabel1.snp.bottom).offset(5.ppaix())
            make.height.equalTo(30.ppaix())
        }
        icon1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 8.ppaix(), height: 12.ppaix()))
            make.right.equalToSuperview().offset(-15.ppaix())
        }
        clickBtn1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nameLabel2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.ppaix())
            make.top.equalTo(grView1.snp.bottom).offset(20.ppaix())
            make.height.equalTo(20.5.ppaix())
        }
        grView2.snp.makeConstraints { make in
            make.left.equalTo(nameLabel2.snp.left)
            make.right.equalToSuperview().offset(-20.ppaix())
            make.top.equalTo(nameLabel2.snp.bottom).offset(5.ppaix())
            make.height.equalTo(30.ppaix())
            make.bottom.equalToSuperview().offset(-14.ppaix())
        }
        clickBtn2.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickBtnClick(_ sender: UIButton) {
        self.block?(sender, [])
    }
    
    @objc func clickBtnClick1(_ sender: UIButton) {
        if let bankArray = model?[1].birds {
            let loanPArray = yijiModel.getyijiArr(dataSourceArr: bankArray)
            self.block1?(sender, loanPArray)
        }
    }
    
    var model: [twitchModel]? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model[0].forcovering
            clickBtn.setTitle(model[0].pester, for: .normal)
            nameLabel1.text = model[1].forcovering
            nameLabel2.text = model[3].forcovering
            clickBtn2.setTitle(model[3].pester, for: .normal)
        }
    }
}

class qurenCell4: UITableViewCell {
    
    var block: ((UIButton, [BRProvinceModel]) -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hex: "#FDFFF6")
        bgView.layer.cornerRadius = 20.ppaix()
        return bgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var nameLabel1: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 16.ppaix())!, textColor: UIColor.init(hex: "#C2C8B0"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var nameLabel2: UILabel = {
        let nameLabel1 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        return nameLabel1
    }()
    
    lazy var nameLabel3: UILabel = {
        let nameLabel1 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 16.ppaix())!, textColor: UIColor.init(hex: "#C2C8B0"), textAlignment: .left)
        return nameLabel1
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(nameLabel1)
        bgView.addSubview(nameLabel2)
        bgView.addSubview(nameLabel3)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(25.5.ppaix())
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-14.ppaix())
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.ppaix())
            make.top.equalToSuperview().offset(20.ppaix())
            make.height.equalTo(20.5.ppaix())
        }
        nameLabel1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.ppaix())
            make.top.equalTo(nameLabel.snp.bottom).offset(10.ppaix())
            make.height.equalTo(20.5.ppaix())
        }
        nameLabel2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.ppaix())
            make.top.equalTo(nameLabel1.snp.bottom).offset(20.ppaix())
            make.height.equalTo(20.5.ppaix())
        }
        nameLabel3.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.ppaix())
            make.top.equalTo(nameLabel2.snp.bottom).offset(10.ppaix())
            make.height.equalTo(20.5.ppaix())
            make.bottom.equalToSuperview().offset(-14.ppaix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: [twitchModel]? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model[0].forcovering
            nameLabel1.text = model[0].pester
            nameLabel2.text = model[1].forcovering
            nameLabel3.text = model[1].pester
        }
    }
}
