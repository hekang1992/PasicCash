//
//  PAPullHeader.swift
//  Pesoin
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
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 15.ppaix())!, textColor: UIColor.init(hex: "#943800"), textAlignment: .center)
        nameLabel.text = "Loading..."
        return nameLabel
    }()

    override func prepare() {
        super.prepare()
        addSubview(headTapView)
        addSubview(nameLabel)
        self.mj_h = 90.ppaix()
    }

    override func placeSubviews() {
        super.placeSubviews()
        headTapView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 72.ppaix(), height: 72.ppaix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headTapView.snp.bottom)
            make.size.equalTo(CGSize(width: 150.ppaix(), height: 16.ppaix()))
        }
    }

}
