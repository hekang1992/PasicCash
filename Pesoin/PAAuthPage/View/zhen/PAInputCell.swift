//
//  PAInputCell.swift
//  Pesoin
//
//  Created by apple on 2024/7/15.
//

import UIKit

class PAInputCell: UITableViewCell {
    
    var model: soundsModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.cordial
            if model.rains == "1" {
                inputField.keyboardType = .numberPad
            }else {
                inputField.keyboardType = .default
            }
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.init(hex: "#CED4BD"),
                .font: UIFont(name: LilitaOneFont, size: 20.ppaix())!
            ]
            let attributedPlaceholder = NSAttributedString(string: model.andmen ?? "", attributes: attributes)
            inputField.attributedPlaceholder = attributedPlaceholder
            inputField.text = model.pester
        }
    }

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        return nameLabel
    }()

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hex: "#FDFFF6")
        bgView.layer.cornerRadius = 15.ppaix()
        bgView.layer.borderWidth = 2.ppaix()
        bgView.layer.borderColor = UIColor.init(hex: "#C6F14D").cgColor
        return bgView
    }()
    
    lazy var inputField: NoCopyPasteTextField = {
        let inputField = NoCopyPasteTextField()
        inputField.font = UIFont(name: LilitaOneFont, size: 20.ppaix())
        inputField.textColor = UIColor.init(hex: "#719F60")
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(hex: "#CED4BD"),
            .font: UIFont(name: LilitaOneFont, size: 20.ppaix())!
        ]
        let attributedPlaceholder = NSAttributedString(string: "Please select marital state", attributes: attributes)
        inputField.attributedPlaceholder = attributedPlaceholder
        inputField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return inputField
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "Sliceshuru")
        return iconImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgView)
        bgView.addSubview(iconImageView)
        bgView.addSubview(inputField)
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(25.ppaix())
            make.top.equalToSuperview().offset(23.ppaix())
            make.height.equalTo(21.ppaix())
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(15.ppaix())
            make.left.equalToSuperview().offset(25.ppaix())
            make.height.equalTo(60.ppaix())
            make.bottom.equalToSuperview()
        }
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-13.ppaix())
            make.size.equalTo(CGSize(width: 30.ppaix(), height: 30.ppaix()))
        }
        inputField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(iconImageView.snp.left).offset(-13.ppaix())
            make.left.equalToSuperview().offset(20.ppaix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PAInputCell {
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if textField == inputField {
            if let model = model {
                model.pester = textField.text
            }
        }
    }
}
