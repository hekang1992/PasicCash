//
//  PAFaceViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/11.
//

import UIKit
import HandyJSON
import Kingfisher

class PAFaceViewController: PABaseViewController {
    
    var productID: String?
    
    var picUrl: String = ""
    
    var startime: String = ""
    
    lazy var faceView: PAFaceView = {
        let faceView = PAFaceView()
        faceView.titleLabel.text = "Validation"
        return faceView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(faceView)
        startime = PADeviceInfo.getCurrentTime()
        faceView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        faceView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        faceView.block1 = { [weak self] in
            if let picUrl = self?.picUrl, picUrl.isEmpty {
                PAMediaManager.shared.presentCamera(from: self!, isfront: "1")
            } else {
                RequestManager.detailPageInfo(productID: self?.productID ?? "", startTime: self?.startime ?? "", type: "") { model1, model2, productID in
                    RequestManager.nextStep(type: model2.smoke ?? "", productID: productID)
                }
            }
        }
        faceView.block2 = { [weak self] in
            PAMediaManager.shared.presentCamera(from: self!, isfront: "1")
        }
    }

}

extension PAFaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let data = Data.yasuoQuality(image: image!, maxLength: 2048)
        picker.dismiss(animated: true) { [weak self] in
            self?.upIconImage(data!,image!)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func upIconImage(_ data: Data, _ image: UIImage) {
        ViewHud.addLoadView()
        var apiUrl = ""
        var dict: [String: Any] = [:]
        if productID == "2" {
            apiUrl = fake_upload_img
            dict["goneup"] = "1"
        }else {
            apiUrl = uploadPic_api
        }
        PARequestManager.shared.uploadAPI(params: dict, pageUrl: apiUrl, method: .post, data: data, complete: { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed) {
                    self?.picUrl = model.lively ?? ""
                    self?.faceView.icon3.kf.indicatorType = .activity
                    let options: KingfisherOptionsInfo = [
                        .transition(.fade(0.2))
                    ]
                    if let indicator = self?.faceView.icon3.kf.indicator?.view as? UIActivityIndicatorView {
                        if #available(iOS 13.0, *) {
                            indicator.style = .medium
                        }
                        indicator.color = .black
                    }
                    self?.faceView.icon3.kf.setImage(with: URL(string: model.lively ?? ""), options: options)
                    self?.sicchfashDali()
                }
            }
            ViewHud.hideLoadView()
        }, errorBlock: { error in
            ViewHud.hideLoadView()
        }, type: "image")
    }
    
    func sicchfashDali() {
        let dict = ["affairs": productID ?? "", "withmiss": "1", "inher": "2"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/fashDali", method: .post) { baseModel in
            
        } errorBlock: { error in
            
        }

    }
}

