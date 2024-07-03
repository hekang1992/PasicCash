//
//  PALaunchViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/2.
//

import UIKit

class PALaunchViewController: PABaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        requestHuanJing()
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

extension PALaunchViewController {
    
    func requestHuanJing() {
        PANetworkManager.shared.observeNetworkStatus { [weak self] status in
            switch status {
            case .none:
                print("无网络连接")
                break
            case .wifi:
                print("网络>>>>>>>WIFI")
                self?.requsetFirstApi()
                break
            case .cellular:
                print("网络>>>>>>>4G/5G")
                self?.requsetFirstApi()
                break
            }
        }
    }
    
    
    func requsetFirstApi() {
        let dict = ["tfollow":"1", "hershe": "1"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: main_api, method: .get) { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let throat = baseModel.shepointed?["throat"] as? String {
                    
                }
            }else {
                
            }
        } errorBlock: { [weak self] error in
            
        }
    }
    
}
