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
            }, to: apiUrl, headers: headers)
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
