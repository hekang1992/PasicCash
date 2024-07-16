//
//  PALoadingView.swift
//  FutureCash
//
//  Created by apple on 2024/4/12.
//

import UIKit
import Foundation
import Lottie

class PALoadingView: UIView {
    
    lazy var grayView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25.ppaix()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()
    
    lazy var hudView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "loading.json", bundle: Bundle.main)
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(grayView)
        grayView.addSubview(hudView)
        setConstraints()
    }
    
    private func setConstraints() {
        grayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        hudView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.size.equalTo(CGSize(width: 144.ppaix(), height: 144.ppaix()))
        }
    }
}

class ViewHud {
    
    static let loadView = PALoadingView()
    
    static func addLoadView() {
        DispatchQueue.main.async {
            if let keyWindow = UIApplication.shared.windows.first {
                DispatchQueue.main.async {
                    loadView.frame = keyWindow.bounds
                    keyWindow.addSubview(loadView)
                }
            }
        }
    }
    
    static func hideLoadView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            loadView.removeFromSuperview()
        }
    }
    
}
