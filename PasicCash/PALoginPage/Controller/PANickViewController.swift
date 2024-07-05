//
//  PANickViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/4.
//

import UIKit

class PANickViewController: PABaseViewController {
    
    lazy var nickView: PANickView = {
        let nickView = PANickView()
        return nickView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(nickView)
        nickView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nickView.block1 = { [weak self] in
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
