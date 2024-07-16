//
//  PALianxiCell.swift
//  PasicCash
//
//  Created by apple on 2024/7/15.
//

import UIKit

class PALianxiCell: UITableViewCell {
    
    var block: ((UIButton) -> Void)?
    
    var block1: ((plantsModel, UILabel, UILabel) -> Void)?
    
    var model: plantsModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.forcovering
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
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "Slicearrow")
        return iconImageView
    }()
    
    lazy var reBtn: UIButton = {
        let reBtn = UIButton(type: .custom)
        reBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 18.ppaix())
        reBtn.setTitle("Relationship", for: .normal)
        reBtn.setTitleColor(UIColor.init(hex: "#CED4BD"), for: .normal)
        reBtn.addTarget(self, action: #selector(relaBtnClick(_ :)), for: .touchUpInside)
        return reBtn
    }()
    
    lazy var bgView1: UIView = {
        let bgView1 = UIView()
        bgView1.backgroundColor = UIColor.init(hex: "#FDFFF6")
        bgView1.layer.cornerRadius = 15.ppaix()
        bgView1.layer.borderWidth = 2.ppaix()
        bgView1.layer.borderColor = UIColor.init(hex: "#C6F14D").cgColor
        return bgView1
    }()
    
    lazy var reBtn1: UIButton = {
        let reBtn1 = UIButton(type: .custom)
        reBtn1.addTarget(self, action: #selector(reBtnClick), for: .touchUpInside)
        return reBtn1
    }()
    
    lazy var nameLabel1: UILabel = {
        let nameLabel1 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#CED4BD"), textAlignment: .center)
        nameLabel1.text = "Name"
        return nameLabel1
    }()
    
    lazy var nameLabel2: UILabel = {
        let nameLabel2 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#CED4BD"), textAlignment: .center)
        nameLabel2.text = "Phone Number"
        return nameLabel2
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgView)
        bgView.addSubview(iconImageView)
        bgView.addSubview(reBtn)
        contentView.addSubview(bgView1)
        bgView1.addSubview(nameLabel1)
        bgView1.addSubview(nameLabel2)
        bgView1.addSubview(reBtn1)
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
        }
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-13.ppaix())
            make.size.equalTo(CGSize(width: 30.ppaix(), height: 30.ppaix()))
        }
        bgView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgView.snp.bottom).offset(15.ppaix())
            make.left.equalToSuperview().offset(25.ppaix())
            make.height.equalTo(98.ppaix())
            make.bottom.equalToSuperview()
        }
        nameLabel1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.left.equalToSuperview()
            make.height.equalTo(49.ppaix())
        }
        nameLabel2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.left.equalToSuperview()
            make.height.equalTo(49.ppaix())
        }
        reBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        reBtn1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PALianxiCell {
    
    @objc func relaBtnClick(_ sender: UIButton) {
        self.block?(sender)
    }
    
    @objc func reBtnClick() {
        if let model = model {
            self.block1?(model ,nameLabel1, nameLabel2)
        }
    }
    
}
