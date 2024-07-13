//
//  PAAlbumView.swift
//  PasicCash
//
//  Created by apple on 2024/7/5.
//

import UIKit

class PAAlbumView: UIView {
    
    var block: (() ->Void)?
    var block1: (() ->Void)?
    var block2: (() ->Void)?

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 30.ppaix()
        bgView.backgroundColor = UIColor.init(hex: "#FDFFF6")
        return bgView
    }()

    lazy var albumBtn: UIButton = {
        let albumBtn = UIButton(type: .custom)
        albumBtn.setTitle("Album", for: .normal)
        albumBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 27.ppaix())
        albumBtn.setTitleColor(UIColor.init(hex: "#1C200D"), for: .normal)
        albumBtn.addTarget(self, action: #selector(albumBtnClick), for: .touchUpInside)
        return albumBtn
    }()
    
    lazy var cameraBtn: UIButton = {
        let cameraBtn = UIButton(type: .custom)
        cameraBtn.setTitle("Camera", for: .normal)
        cameraBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 27.ppaix())
        cameraBtn.setTitleColor(UIColor.init(hex: "#1C200D"), for: .normal)
        cameraBtn.addTarget(self, action: #selector(cameraBtnClick), for: .touchUpInside)
        return cameraBtn
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 27.ppaix())
        cancelBtn.setTitleColor(UIColor.init(hex: "#CED4BD"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        return cancelBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(albumBtn)
        bgView.addSubview(cameraBtn)
        bgView.addSubview(cancelBtn)
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 320.ppaix(), height: 300.ppaix()))
        }
        albumBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.ppaix())
            make.right.left.equalToSuperview()
            make.height.equalTo(100.ppaix())
        }
        cameraBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(albumBtn.snp.bottom)
            make.height.equalTo(100.ppaix())
        }
        cancelBtn.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(cameraBtn.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PAAlbumView {
    
    @objc func albumBtnClick() {
        self.block?()
    }
    
    @objc func cameraBtnClick() {
        self.block1?()
    }
    
    @objc func cancelBtnClick() {
        self.block2?()
    }
    
}
