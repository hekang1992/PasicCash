//
//  PARequestManager.swift
//  PasicCash
//
//  Created by apple on 2024/7/3.
//

import UIKit
import Alamofire
import HandyJSON

class PARequestManager: NSObject {
    
    static let shared = PARequestManager()
    
    typealias CompleteBlock = (_ baseModel: BaseModel) -> Void
    
    typealias NSErrorBlock = (_ error: Any) -> Void
    
    let headers: HTTPHeaders = [
        "Accept": "application/json;",
        "Connection": "keep-alive",
        "Content-Type": "application/x-www-form-urlencoded;text/json;text/javascript;text/html;text/plain;multipart/form-data"]
}


extension PARequestManager {
    
    func requestAPI(params: [String: Any]?,
                    pageUrl: String,
                    method: HTTPMethod,
                    complete: @escaping CompleteBlock,
                    errorBlock: @escaping NSErrorBlock){
        if let apiUrl = createURL(baseURL: BASE_URL + "/hapyy" + pageUrl, params: PALoginFactory.getLoginParas()) {
            let apiUrlString = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            AF.request(apiUrlString, method: method, parameters: params, headers: headers).responseData { response in
                switch response.result {
                case .success(_):
                    if response.data == nil {
                        print("no data")
                        errorBlock("failureData")
                    }else {
                        let jsonStr = NSString(data:response.data! ,encoding: String.Encoding.utf8.rawValue)
                        if let model = JSONDeserializer<BaseModel>.deserializeFrom(json: jsonStr as String?) {
                            if model.handsto == -2 {
                                complete(model)
                            }else {
                                complete(model)
                            }
                        }
                    }
                    break
                case .failure(let failureData):
                    errorBlock(failureData)
                    break
                }
            }
        }
    }
    
    func uploadAPI(params: [String: Any]?,
                   pageUrl: String,
                   method: HTTPMethod,
                   data: Data,
                   complete: @escaping CompleteBlock,
                   errorBlock: @escaping NSErrorBlock,
                   type: String){
        if let apiUrl = createURL(baseURL: BASE_URL + "/hapyy" + pageUrl, params: PALoginFactory.getLoginParas()) {
            let apiUrlString = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            AF.upload(multipartFormData: { multipartFormData in
                if type == "image" {
                    multipartFormData.append(data, withName: "tinkling", fileName: "tinkling.png", mimeType: "image/png")
                }
                if let params = params {
                    for (key, value) in params {
                        let value :String! = value as? String
                        multipartFormData.append(value.data(using: .utf8)!, withName: key)
                    }
                }
            }, to: apiUrlString, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(_):
                    if response.data == nil {
                        print("no data")
                        errorBlock("failureData")
                    }else {
                        let jsonStr = NSString(data:response.data! ,encoding: String.Encoding.utf8.rawValue)
                        if let model = JSONDeserializer<BaseModel>.deserializeFrom(json: jsonStr as String?) {
                            if model.handsto == -2 {
                                complete(model)
                            }else {
                                complete(model)
                            }
                        }
                        
                    }
                    break
                case .failure(let failureData):
                    errorBlock(failureData)
                    break
                }
            }
        }
    }
    
    
    func createURL(baseURL: String, params: [String: String]) -> String? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            print("NO URL")
            return nil
        }
        var queryItems = [URLQueryItem]()
        for (key, value) in params {
            let queryItem = URLQueryItem(name: key, value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            queryItems.append(queryItem)
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url?.absoluteString
    }
    
}


class RequestManager {
    
    typealias CompletionHandler = (myshouldersModel, framesModel, String) -> Void
    
    static func applyClick(productID: String, completion: ((String) -> Void)?) {
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
    
    static func judguUrlSche(_ url: String) {
        if url.hasPrefix(SCHEME_URL) {
            if url.contains("burdenedRiver") {//产品详情
                let array = url.components(separatedBy: "affairs=")
                detailPageInfo(productID: array.last ?? "", startTime: "", type: "") { model1, model2, productID in
                    let orderID = model1.nightshirts ?? ""
                    let step = model2.smoke ?? ""
                    if !step.isEmpty {
                        RequestManager.nextStep(type: step, productID: productID)
                    }else {
                        
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
            
        }
    }
    
    static func detailPageInfo(productID: String, startTime: String, type: String, completion: @escaping CompletionHandler) {
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
    
    static func nextStep(type: String, productID: String) {
        switch type {
        case "her1":
            if productID == "2" {
                let viewController = PAAuthIDViewController()
                if let rootNavController = NavigationControllerHelper.getRootNavigationController() {
                    viewController.productID = productID
                    rootNavController.pushViewController(viewController, animated: true)
                }
            } else {
                getOneShenfenxinxi(productID: productID) // 获取用户身份信息
            }
        case "her2":
            let viewController = PAGeRenViewController()
            if let rootNavController = NavigationControllerHelper.getRootNavigationController() {
                viewController.productID = productID
                rootNavController.pushViewController(viewController, animated: true)
            }
            break
        case "her3":
            let viewController = PAWorkViewController()
            if let rootNavController = NavigationControllerHelper.getRootNavigationController() {
                viewController.productID = productID
                rootNavController.pushViewController(viewController, animated: true)
            }
            break
        case "her4":
            let viewController = PALianxiViewController()
            if let rootNavController = NavigationControllerHelper.getRootNavigationController() {
                viewController.productID = productID
                rootNavController.pushViewController(viewController, animated: true)
            }
            break
        case "her5":
            if productID == "2" {
                let viewController = PABankViewController()
                if let rootNavController = NavigationControllerHelper.getRootNavigationController() {
                    viewController.productID = productID
                    rootNavController.pushViewController(viewController, animated: true)
                }
            }else {
                let viewController = PABankViewController()
                if let rootNavController = NavigationControllerHelper.getRootNavigationController() {
                    viewController.productID = productID
                    rootNavController.pushViewController(viewController, animated: true)
                }
            }
            break
        case "her6":
            let viewController = PAFaceViewController()
            if let rootNavController = NavigationControllerHelper.getRootNavigationController() {
                viewController.productID = productID
                rootNavController.pushViewController(viewController, animated: true)
            }
            break
        default:
            break
        }
    }
    
    static func queVc(productID: String) {
        let queVc = PAQueViewController()
        if let rootNavController = NavigationControllerHelper.getRootNavigationController() {
            queVc.productID = productID
            rootNavController.pushViewController(queVc, animated: true)
        }
    }
    
    static func dingVc(productID: String) {
        let queVc = PAPendingViewController()
        if let rootNavController = NavigationControllerHelper.getRootNavigationController() {
            queVc.productID = productID
            rootNavController.pushViewController(queVc, animated: true)
        }
    }
    
    static func getOneShenfenxinxi(productID: String) {
        ViewHud.addLoadView()
        let dict = ["affairs": productID, "index": "1", "againuntil": "2"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/coldestDeparture", method: .post) { baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed), let modelArray = model.andcrept?.plants {
                    let someday = modelArray[0].someday
                    if someday == "0" {
                        //11 zhang
                        let shiyiVc = PAShiYiViewController()
                        if let rootNavController = NavigationControllerHelper.getRootNavigationController() {
                            shiyiVc.productID = productID
                            rootNavController.pushViewController(shiyiVc, animated: true)
                        }
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
    
}

