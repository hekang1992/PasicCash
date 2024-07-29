//
//  PAAboutView.swift
//  Pesoin
//
//  Created by apple on 2024/7/17.
//

import UIKit

class PAAboutView: PACommonView {
    
    var block1: ((String) -> Void)?
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "AppIcon")
        return iconImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .center)
        nameLabel.text = "v1.0.0"
        return nameLabel
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.layer.cornerRadius = 20.ppaix()
        whiteView.backgroundColor = UIColor.init(hex: "#FDFFF6")
        return whiteView
    }()
    
    lazy var whiteView1: UIView = {
        let whiteView1 = UIView()
        whiteView1.layer.cornerRadius = 20.ppaix()
        whiteView1.backgroundColor = UIColor.init(hex: "#FDFFF6")
        return whiteView1
    }()
    
    lazy var daikuanLabel1: UILabel = {
        let nameLabel1 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .center)
        nameLabel1.text = "Loan Provider Information"
        return nameLabel1
    }()
    
    lazy var daikuanLabel2: UILabel = {
        let nameLabel2 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#C7CABB"), textAlignment: .center)
        nameLabel2.text = "LINK CREDIT LENDING INVESTORS INC."
        return nameLabel2
    }()
    
    lazy var daikuanLabel3: UILabel = {
        let nameLabel3 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .center)
        nameLabel3.text = "C.A.No.3072"
        return nameLabel3
    }()
    
    lazy var daikuanLabel4: UILabel = {
        let nameLabel4 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .center)
        nameLabel4.text = "SEC No.CS201914644"
        return nameLabel4
    }()
    
    lazy var nameLabel1: UILabel = {
        let nameLabel1 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .center)
        nameLabel1.text = "Company info"
        return nameLabel1
    }()
    
    lazy var nameLabel2: UILabel = {
        let nameLabel2 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#C7CABB"), textAlignment: .center)
        nameLabel2.text = "PASIG-BORONGAN LENDING CORP."
        return nameLabel2
    }()
    
    lazy var nameLabel3: UILabel = {
        let nameLabel3 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .center)
        nameLabel3.text = "C.A.No.2154"
        return nameLabel3
    }()
    
    lazy var nameLabel4: UILabel = {
        let nameLabel4 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .center)
        nameLabel4.text = "SEC No.CS201709377"
        return nameLabel4
    }()
    
    lazy var nameLabel5: UILabel = {
        let nameLabel5 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .center)
        nameLabel5.text = "Address"
        return nameLabel5
    }()
    
    lazy var nameLabel6: UILabel = {
        let nameLabel6 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#C7CABB"), textAlignment: .center)
        nameLabel6.text = "210 General Capinpin Street 4024 Binan"
        return nameLabel6
    }()
    
    lazy var nameLabel7: UILabel = {
        let nameLabel5 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .center)
        nameLabel5.text = "Website"
        return nameLabel5
    }()
    
    lazy var nameLabel8: UILabel = {
        let nameLabel6 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#C6F23D"), textAlignment: .center)
        nameLabel6.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        nameLabel6.addGestureRecognizer(tapGesture)
        nameLabel6.text = "https://pasigborongan.com/"
        return nameLabel6
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.addSubview(iconImageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(whiteView1)
        whiteView1.addSubview(daikuanLabel1)
        whiteView1.addSubview(daikuanLabel2)
        whiteView1.addSubview(daikuanLabel3)
        whiteView1.addSubview(daikuanLabel4)
        scrollView.addSubview(whiteView)
        whiteView.addSubview(nameLabel1)
        whiteView.addSubview(nameLabel2)
        whiteView.addSubview(nameLabel3)
        whiteView.addSubview(nameLabel4)
        whiteView.addSubview(nameLabel5)
        whiteView.addSubview(nameLabel6)
        whiteView.addSubview(nameLabel7)
        whiteView.addSubview(nameLabel8)
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(35.ppaix())
            make.size.equalTo(CGSize(width: 70.ppaix(), height: 70.ppaix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom).offset(15.ppaix())
            make.size.equalTo(CGSize(width: 180.ppaix(), height: 21.ppaix()))
        }
        whiteView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(30.ppaix())
            make.left.equalToSuperview().offset(20.ppaix())
            make.height.equalTo(200.ppaix())
        }
        daikuanLabel1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30.ppaix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 280.ppaix(), height: 20.ppaix()))
        }
        daikuanLabel2.snp.makeConstraints { make in
            make.top.equalTo(daikuanLabel1.snp.bottom).offset(15.ppaix())
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(20.ppaix())
        }
        daikuanLabel3.snp.makeConstraints { make in
            make.top.equalTo(daikuanLabel2.snp.bottom).offset(20.ppaix())
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(20.ppaix())
        }
        daikuanLabel4.snp.makeConstraints { make in
            make.top.equalTo(daikuanLabel3.snp.bottom).offset(15.ppaix())
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(20.ppaix())
        }
        whiteView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(whiteView1.snp.bottom).offset(30.ppaix())
            make.left.equalToSuperview().offset(20.ppaix())
            make.height.equalTo(346.ppaix())
            make.bottom.equalToSuperview().offset(-50.ppaix())
        }
        nameLabel1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30.ppaix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200.ppaix(), height: 20.ppaix()))
        }
        nameLabel2.snp.makeConstraints { make in
            make.top.equalTo(nameLabel1.snp.bottom).offset(15.ppaix())
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(20.ppaix())
        }
        nameLabel3.snp.makeConstraints { make in
            make.top.equalTo(nameLabel2.snp.bottom).offset(20.ppaix())
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(20.ppaix())
        }
        nameLabel4.snp.makeConstraints { make in
            make.top.equalTo(nameLabel3.snp.bottom).offset(15.ppaix())
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(20.ppaix())
        }
        nameLabel5.snp.makeConstraints { make in
            make.top.equalTo(nameLabel4.snp.bottom).offset(30.ppaix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200.ppaix(), height: 20.ppaix()))
        }
        nameLabel6.snp.makeConstraints { make in
            make.top.equalTo(nameLabel5.snp.bottom).offset(15.ppaix())
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(20.ppaix())
        }
        nameLabel7.snp.makeConstraints { make in
            make.top.equalTo(nameLabel6.snp.bottom).offset(30.ppaix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200.ppaix(), height: 20.ppaix()))
        }
        nameLabel8.snp.makeConstraints { make in
            make.top.equalTo(nameLabel7.snp.bottom).offset(15.ppaix())
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(20.ppaix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PAAboutView {
    
    
    @objc func labelTapped() {
        self.block1?("https://pasigborongan.com/")
    }
    
}
