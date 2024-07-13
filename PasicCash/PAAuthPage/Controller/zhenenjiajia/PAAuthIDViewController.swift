//
//  PAAuthIDViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/11.
//

import UIKit
import TYAlertController
import HandyJSON
import MBProgressHUD_WJExtension
import Kingfisher

class PAAuthIDViewController: PABaseViewController {
    
    var productID: String?
    
    var picUrl: String = ""
    
    var startime: String = ""
    
    lazy var albumView: PAAlbumView = {
        let albumView = PAAlbumView(frame: self.view.bounds)
        return albumView
    }()
    
    lazy var idView: PAAuthIDView = {
        let idView = PAAuthIDView()
        idView.titleLabel.text = "Validation"
        return idView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(idView)
        startime = PADeviceInfo.getCurrentTime()
        idView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        idView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        idView.block1 = { [weak self] in
            if let picUrl = self?.picUrl, picUrl.isEmpty {
                self?.popPhotot()
            } else {
                RequestManager.detailPageInfo(productID: self?.productID ?? "", startTime: self?.startime ?? "", type: "") { model1, model2, productID in
                    RequestManager.nextStep(type: model2.smoke ?? "", productID: productID)
                }
            }
        }
        idView.block2 = { [weak self] in
            self?.popPhotot()
        }
    }
}


extension PAAuthIDViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func popPhotot() {
        let alertVc = TYAlertController(alert: albumView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        albumView.block2 = { [weak self] in
            self?.dismiss(animated: true)
        }
        albumView.block = { [weak self] in
            self?.dismiss(animated: true, completion: {
                PAMediaManager.shared.presentPhotoLibrary(from: self!)
            })
        }
        albumView.block1 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                PAMediaManager.shared.presentCamera(from: self!, isfront: "0")
            })
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
            dict["goneup"] = "1"
        }else {
            apiUrl = "/sicch/oneSese"
        }
        PARequestManager.shared.uploadAPI(params: dict, pageUrl: apiUrl, method: .post, data: data, complete: { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed) {
                    self?.picUrl = model.lively ?? ""
                    self?.idView.icon3.kf.indicatorType = .activity
                    let options: KingfisherOptionsInfo = [
                        .transition(.fade(0.2))
                    ]
                    if let indicator = self?.idView.icon3.kf.indicator?.view as? UIActivityIndicatorView {
                        if #available(iOS 13.0, *) {
                            indicator.style = .medium
                        }
                        indicator.color = .black
                    }
                    self?.idView.icon3.kf.setImage(with: URL(string: model.lively ?? ""), options: options)
                }
            }
            ViewHud.hideLoadView()
        }, errorBlock: { error in
            ViewHud.hideLoadView()
        }, type: "image")
    }
}
