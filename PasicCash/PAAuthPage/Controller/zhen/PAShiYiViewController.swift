//
//  PAShiYiViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/13.
//

import UIKit

class PAShiYiViewController: PABaseViewController {
    
    var productID: String?
    
    lazy var shiyiView: PAShiYiView = {
        let shiyiView = PAShiYiView()
        shiyiView.titleLabel.text = "Card Type"
        return shiyiView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(shiyiView)
        shiyiView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
