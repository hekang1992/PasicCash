//
//  PACodeViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/4.
//

import UIKit

class PACodeViewController: PABaseViewController {
    
    var totalTime = 60
    
    var countdownTimer: Timer!
    
    lazy var codeView: PACodeView = {
        let codeView = PACodeView()
        return codeView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(codeView)
        codeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        codeView.block = { [weak self] in
            let nickVc = PANickViewController()
            self?.navigationController?.pushViewController(nickVc, animated: true)
        }
        codeView.block1 = { [weak self] in
            self?.startTimer()
        }
        codeView.block2 = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

}


extension PACodeViewController {
    
    func startTimer() {
        self.codeView.codeBtn.isEnabled = false
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        if totalTime > 0 {
            totalTime -= 1
            UIView.animate(withDuration: 0.25) {
                self.codeView.codeBtn.setTitle("", for: .normal)
                self.codeView.codeBtn.setTitleColor(UIColor.init(hex: "#FEE610"), for: .normal)
                self.codeView.codeBtn.layer.cornerRadius = 20.pix()
                self.codeView.codeBtn.snp.updateConstraints { make in
                    make.size.equalTo(CGSizeMake(40.pix(), 40.pix()))
                }
                self.codeView.layoutIfNeeded()
            } completion: { _ in
                self.codeView.codeBtn.setTitle("\(self.totalTime)s", for: .normal)
            }
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        self.codeView.codeBtn.isEnabled = true
        self.codeView.codeBtn.setTitle("Resend code", for: .normal)
        UIView.animate(withDuration: 0.25) {
            self.codeView.codeBtn.layer.cornerRadius = 15.pix()
            self.codeView.codeBtn.setTitleColor(UIColor.white, for: .normal)
            self.codeView.codeBtn.snp.updateConstraints { make in
                make.size.equalTo(CGSizeMake(110.pix(), 40.pix()))
            }
            self.codeView.layoutIfNeeded()
        }
        totalTime = 60
    }
}
