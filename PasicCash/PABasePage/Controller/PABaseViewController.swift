//
//  PABaseViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/2.
//

import UIKit
import HandyJSON

class PABaseViewController: UIViewController {
    
    lazy var nodataView: PANoDataView = {
        let nodataView = PANoDataView()
        return nodataView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
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

extension PABaseViewController {
    
    typealias CompletionHandler = (myshouldersModel, framesModel, String) -> Void
    
    func applyClick(productID: String, completion: ((String) -> Void)?) {
        ViewHud.addLoadView()
        let dict = ["affairs": productID, "withmiss": "1", "inher": "1"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/shortShaking", method: .post) { baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed) {
                    completion?(model.nightwas ?? "")
                }
            }
            ViewHud.hideLoadView()
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
        
    }
    
    func judguUrlSche(_ url: String) {
        if url.hasPrefix(SCHEME_URL) {
            if url.contains("burdenedRiver") {//产品详情
                let array = url.components(separatedBy: "affairs=")
                detailPageInfo(productID: array.last ?? "", startTime: "", type: "") { [weak self] model1, model2, productID in
                    let orderID = model1.nightshirts ?? ""
                    let step = model2.smoke ?? ""
                    if !step.isEmpty {
                        self?.nextStep(type: step, productID: productID)
                    }else {
                        //dingdantiaozhuan
                        self?.ordertVc(orderID: orderID, productID: productID)
                    }
                }
            }else if url.contains("notOk") {
                let array = url.components(separatedBy: "affairs=")
                queVc(productID: array.last ?? "")
            }else if url.contains("yourOk") {
                let array = url.components(separatedBy: "affairs=")
                dingVc(productID: array.last ?? "")
            }
        }else {
            let viewController = PAWebViewController()
            PATabBarManager.hideTabBar()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func detailPageInfo(productID: String, startTime: String, type: String, completion: @escaping CompletionHandler) {
        ViewHud.addLoadView()
        let dict = ["affairs": productID, "handextinguishers": "1", "therewas": "1"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/jemWehad", method: .post) { baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed)
                if let model = model, let myshoulders = model.myshoulders{
                    if let frames = model.frames {
                        completion(myshoulders, frames, productID)
                    }else {
                        completion(myshoulders, framesModel(), productID)
                    }
                }
            }
            ViewHud.hideLoadView()
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func nextStep(type: String, productID: String) {
        switch type {
        case "her1":
            if productID == "2" {
                let viewController = PAAuthIDViewController()
                viewController.productID = productID
                PATabBarManager.hideTabBar()
                self.navigationController?.pushViewController(viewController, animated: true)
            } else {
                getOneShenfenxinxi(productID: productID) // 获取用户身份信息
            }
        case "her2":
            let viewController = PAGeRenViewController()
            viewController.productID = productID
            PATabBarManager.hideTabBar()
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        case "her3":
            let viewController = PAWorkViewController()
            viewController.productID = productID
            PATabBarManager.hideTabBar()
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        case "her4":
            let viewController = PALianxiViewController()
            viewController.productID = productID
            PATabBarManager.hideTabBar()
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        case "her5":
            if productID == "2" {
                let viewController = PABankViewController()
                viewController.productID = productID
                PATabBarManager.hideTabBar()
                self.navigationController?.pushViewController(viewController, animated: true)
            }else {
                let viewController = PALQianBaoViewController()
                viewController.productID = productID
                PATabBarManager.hideTabBar()
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            break
        case "her6":
            let viewController = PAFaceViewController()
            viewController.productID = productID
            PATabBarManager.hideTabBar()
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        default:
            break
        }
    }
    
    func queVc(productID: String) {
        let queVc = PAQueViewController()
        queVc.productID = productID
        PATabBarManager.hideTabBar()
        self.navigationController?.pushViewController(queVc, animated: true)
    }
    
    func dingVc(productID: String) {
        let queVc = PAPendingViewController()
        queVc.productID = productID
        PATabBarManager.hideTabBar()
        self.navigationController?.pushViewController(queVc, animated: true)
    }
    
    func getOneShenfenxinxi(productID: String) {
        ViewHud.addLoadView()
        let dict = ["affairs": productID, "index": "1", "againuntil": "2"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/coldestDeparture", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed), let modelArray = model.andcrept?.plants {
                    let someday = modelArray[0].someday
                    if someday == "0" {
                        //11 zhang
                        let shiyiVc = PAShiYiViewController()
                        shiyiVc.productID = productID
                        PATabBarManager.hideTabBar()
                        self?.navigationController?.pushViewController(shiyiVc, animated: true)
                    }else  {
                        // renlian
                    }
                }
            }
            ViewHud.hideLoadView()
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func ordertVc(orderID: String, productID: String) {
        ViewHud.addLoadView()
        let dict = ["potted": orderID,
                    "affairs": productID,
                    "portraitpainter": "1",
                    "thenlaughed": "2",
                    "hesaw": "3"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/comingBending", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed), let nightwas = model.nightwas {
                    self?.pushWeb(productID: productID)
                }
            }
            ViewHud.hideLoadView()
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func pushWeb(productID: String) {
        let webVc = PAWebViewController()
        webVc.productID = productID
        PATabBarManager.hideTabBar()
        navigationController?.pushViewController(webVc, animated: true)
    }
    
}
