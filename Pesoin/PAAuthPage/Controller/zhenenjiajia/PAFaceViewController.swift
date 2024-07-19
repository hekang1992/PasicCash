//
//  PAFaceViewController.swift
//  Pesoin
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
        if productID != "2" {
            let attributedString = NSMutableAttributedString(string: "Continue")
            attributedString.addAttribute(.foregroundColor, value: UIColor.init(hex: "#FEE610") , range: NSRange(location: 0, length: 8))
            faceView.nextBtn.setAttributedTitle(attributedString, for: .normal)
        }
        return faceView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let serialQueue = DispatchQueue(label: "com.example.serialQueue")

        view.addSubview(faceView)
        startime = PADeviceInfo.getCurrentTime()
        faceView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        faceView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        faceView.block1 = { [weak self] in
            if let picUrl = self?.picUrl, picUrl.isEmpty {
                PAMediaManager.shared.presentCamera(from: self!, isfront: "1")
            } else {
                self?.sicchfashDali {
                    serialQueue.async {
                        self?.detailPageInfo(productID: self?.productID ?? "", startTime: self?.startime ?? "", type: "") { model1, model2, productID in
                            self?.nextStep(type: model2.smoke ?? "", productID: productID)
                        }
                    }
                }
            }
        }
        faceView.block2 = { [weak self] in
            PAMediaManager.shared.presentCamera(from: self!, isfront: "1")
        }
        huoquyonghuxinxi()
    }

}

extension PAFaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func huoquyonghuxinxi() {
        PARequestManager.shared.requestAPI(params: [:], pageUrl: "/sicch/whatArYour", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed), let nickModel = model.overcoat {
                    let redFine = nickModel.redFine ?? ""
                    self?.picUrl = redFine
                    if !redFine.isEmpty {
                        self?.faceView.icon3.kf.setImage(with: URL(string: nickModel.redFine ?? ""))
                    }
                }
            }
            ViewHud.hideLoadView()
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
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
            apiUrl = "/sicch/iwantToHere"
            dict["goneup"] = "2"
        }else {
            apiUrl = "/sicch/oneSese"
            dict["goneup"] = "10"
            dict["affairs"] = productID
            dict["burst"] = "1"
            dict["letyou"] = "1"
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
                    self?.sicchfashDali(completion: {
                        
                    })
                }
                self?.appmaidain(productID: self?.productID ?? "", type: "4", startTime: self?.startime ?? "")
            }
            ViewHud.hideLoadView()
        }, errorBlock: { error in
            ViewHud.hideLoadView()
        }, type: "image")
    }
    
    func sicchfashDali(completion: @escaping () -> Void) {
        let dict = ["affairs": productID ?? "", "withmiss": "1", "inher": "2"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/fashDali", method: .post) { baseModel in
            completion()
        } errorBlock: { error in
            completion()
        }
    }
    
}

