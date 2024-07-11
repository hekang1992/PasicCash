//
//  PAAuthIDViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/11.
//

import UIKit

class PAAuthIDViewController: PABaseViewController {
    
    lazy var idView: PAAuthIDView = {
        let idView = PAAuthIDView()
        idView.titleLabel.text = "Validation"
        return idView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(idView)
        idView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        idView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
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
