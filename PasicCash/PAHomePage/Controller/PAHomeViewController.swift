//
//  PAHomeViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/2.
//

import UIKit

class PAHomeViewController: PABaseViewController {

    
    lazy var btn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.setTitle("点我", for: .normal)
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 15.pix()
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .random()
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PAHomeViewController {
    
    @objc func btnClick() {
        let abc = PAUserViewController()
        self.navigationController?.pushViewController(abc, animated: true)
    }
    
}
