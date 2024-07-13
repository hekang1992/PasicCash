//
//  PAExpanView.swift
//  PasicCash
//
//  Created by apple on 2024/7/10.
//

import UIKit
import SnapKit

class PAExpanView: UIView {
    
    var block1: (() -> Void)?
    
    var block2: (() -> Void)?
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Slicearrow")
        return icon
    }()
    
    lazy var agreeBtn: UIButton = {
        let agreeBtn = UIButton(type: .custom)
        agreeBtn.setTitleColor(UIColor.init(hex: "#1C200D"), for: .normal)
        agreeBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 18.ppaix())
        agreeBtn.addTarget(self, action: #selector(agreeClick(_ :)), for: .touchUpInside)
        return agreeBtn
    }()
    
    lazy var daikuanBtn: UIButton = {
        let daikuanBtn = UIButton(type: .custom)
        daikuanBtn.alpha = 0
        daikuanBtn.setTitle("", for: .normal)
        daikuanBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 18.ppaix())
        daikuanBtn.addTarget(self, action: #selector(daikuanBtnClick), for: .touchUpInside)
        return daikuanBtn
    }()
    
    lazy var yinsiBtn: UIButton = {
        let yinsiBtn = UIButton(type: .custom)
        yinsiBtn.alpha = 0
        yinsiBtn.setTitle("", for: .normal)
        yinsiBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 18.ppaix())
        yinsiBtn.addTarget(self, action: #selector(yinsiBtnClick), for: .touchUpInside)
        return yinsiBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(icon)
        addSubview(agreeBtn)
        addSubview(daikuanBtn)
        addSubview(yinsiBtn)
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15.ppaix())
            make.right.equalToSuperview().offset(-22.ppaix())
            make.size.equalTo(CGSize(width: 30.ppaix(), height: 30.ppaix()))
        }
        agreeBtn.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(60.ppaix())
        }
        daikuanBtn.snp.makeConstraints { make in
            make.top.equalTo(agreeBtn.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(21.ppaix())
        }
        yinsiBtn.snp.makeConstraints { make in
            make.top.equalTo(daikuanBtn.snp.bottom).offset(20.ppaix())
            make.left.right.equalToSuperview()
            make.height.equalTo(21.ppaix())
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PAExpanView {
    
    @objc func agreeClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        UIView.animate(withDuration: 0.25) {
            self.icon.transform = sender.isSelected ? CGAffineTransform(rotationAngle: .pi / 2) : CGAffineTransform.identity
            self.yinsiBtn.alpha = sender.isSelected ? 1 : 0
            self.daikuanBtn.alpha = sender.isSelected ? 1 : 0
            self.snp.updateConstraints { make in
                make.height.equalTo(sender.isSelected ? 141.ppaix() : 60.ppaix())
            }
            self.superview?.layoutIfNeeded()
        }
    }
    
    @objc func daikuanBtnClick() {
        self.block1?()
    }
    
    @objc func yinsiBtnClick() {
        self.block2?()
    }
}
