//
//  PAPopQueView.swift
//  Pesoin
//
//  Created by apple on 2024/7/12.
//

import UIKit

class PAPopQueView: UIView {
    
    var block: (() -> Void)?

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.contentMode = .scaleAspectFit
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = UIImage(named: "Group_que")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(taapped))
        bgImageView.addGestureRecognizer(tapGesture)
        return bgImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.ppaix(), height: 525.ppaix()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PAPopQueView {
    
    @objc func taapped() {
        self.block?()
    }
    
}
