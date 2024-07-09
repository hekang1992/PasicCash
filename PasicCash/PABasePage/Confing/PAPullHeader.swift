//
//  PAPullHeader.swift
//  PasicCash
//
//  Created by apple on 2024/7/8.
//

import UIKit
import MJRefresh
import Lottie

class PAPullHeader: MJRefreshHeader {

    lazy var headTapView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "loading.json", bundle: Bundle.main)
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.createLabel(font: UIFont(name: LilitaOneFont, size: 15.pix())!, textColor: UIColor.init(hex: "#943800"), textAlignment: .center)
        nameLabel.text = "Loading..."
        return nameLabel
    }()

    override func prepare() {
        super.prepare()
        addSubview(headTapView)
        addSubview(nameLabel)
        self.mj_h = 80.pix()
    }

    override func placeSubviews() {
        super.placeSubviews()
        headTapView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 72.pix(), height: 72.pix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headTapView.snp.bottom)
            make.size.equalTo(CGSize(width: 150.pix(), height: 16.pix()))
        }
    }

}
