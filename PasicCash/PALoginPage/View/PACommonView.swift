//
//  PACommonView.swift
//  PasicCash
//
//  Created by apple on 2024/7/11.
//

import UIKit

class PACommonView: UIView {
    
    var block: (() -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()

    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "Slice_2"), for: .normal)
        backBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return backBtn
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.createLabel(font: UIFont(name: LilitaOneFont, size: 20.pix())!, textColor: UIColor.init(hex: "#1E230F"), textAlignment: .center)
        return titleLabel
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(backBtn)
        bgView.addSubview(titleLabel)
        bgView.addSubview(scrollView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(52.pix())
            make.height.equalTo(23.pix())
        }
        backBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50.pix())
            make.left.equalToSuperview().offset(25.pix())
            make.size.equalTo(CGSize(width: 30.pix(), height: 30.pix()))
        }
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(backBtn.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradient()
    }
    
}

extension PACommonView {
    
    @objc func btnClick() {
        self.block?()
    }
    
    func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bgView.bounds
        gradientLayer.colors = [
            UIColor.init(hex: "#B7EC2B").cgColor,
            UIColor.init(hex: "#FCFFF2").cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.92, y: 0.08)
        gradientLayer.endPoint = CGPoint(x: 0.92, y: 0.92)
        bgView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
