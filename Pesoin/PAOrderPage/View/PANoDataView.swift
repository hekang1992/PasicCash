//
//  PANoDataView.swift
//  Pesoin
//
//  Created by apple on 2024/7/16.
//

import UIKit

class PANoDataView: UIView {

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 30.ppaix())!, textColor: UIColor.init(hex: "#FC4C4D"), textAlignment: .center)
        nameLabel.text = "NO DATA!"
        return nameLabel
    }()
    
    lazy var faceImageView: UIImageView = {
        let faceImageView = UIImageView()
        faceImageView.image = UIImage(named: "faccrying-face")
        return faceImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(faceImageView)
        faceImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 120.ppaix(), height: 120.ppaix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(faceImageView.snp.bottom).offset(10.ppaix())
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(40.ppaix())
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

