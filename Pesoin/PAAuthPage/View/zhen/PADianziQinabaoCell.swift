//
//  PADianziQinabaoCell.swift
//  Pesoin
//
//  Created by apple on 2024/7/16.
//

import UIKit

class PADianziQinabaoCell: UITableViewCell {
    
    var block: ((UITextField, UIImageView) -> Void)?
    
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

    lazy var inputField: UITextField = {
        let inputField = UITextField()
        inputField.font = UIFont(name: LilitaOneFont, size: 20.ppaix())
        inputField.textColor = UIColor.init(hex: "#719F60")
        inputField.isEnabled = false
        return inputField
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "Slicearrow")
        return iconImageView
    }()
    
    lazy var iconImageView1: UIImageView = {
        let iconImageView1 = UIImageView()
        iconImageView1.layer.cornerRadius = 15.ppaix()
        iconImageView1.layer.masksToBounds = true
        iconImageView1.image = UIImage(named: "Group_1099")
        return iconImageView1
    }()
    
    lazy var selectBtn: UIButton = {
        let selectBtn = UIButton(type: .custom)
        selectBtn.addTarget(self, action: #selector(selectBtnClick(_ :)), for: .touchUpInside)
        return selectBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgView)
        contentView.addSubview(iconImageView1)
        bgView.addSubview(iconImageView)
        bgView.addSubview(inputField)
        bgView.addSubview(selectBtn)
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(25.ppaix())
            make.top.equalToSuperview().offset(23.ppaix())
            make.height.equalTo(21.ppaix())
        }
        iconImageView1.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(13.ppaix())
            make.left.equalToSuperview().offset(23.ppaix())
            make.size.equalTo(CGSize(width: 64.ppaix(), height: 64.ppaix()))
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15.ppaix())
            make.left.equalTo(iconImageView1.snp.right).offset(13.ppaix())
            make.height.equalTo(60.ppaix())
            make.right.equalToSuperview().offset(-25.ppaix())
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
        selectBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PADianziQinabaoCell {
    
    @objc func selectBtnClick(_ sender: UIButton) {
        self.block?(inputField, iconImageView1)
    }
}
