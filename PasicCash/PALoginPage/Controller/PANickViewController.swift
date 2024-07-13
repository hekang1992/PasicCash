//
//  PANickViewController.swift
//  PasicCash
//
//  Created by apple on 2024/7/4.
//

import UIKit
import TYAlertController
import HandyJSON
import MBProgressHUD_WJExtension

class PANickViewController: PABaseViewController {
    
    var picUrl: String = ""
    
    var recipecalled: String = "1"
    
    lazy var nickView: PANickView = {
        let nickView = PANickView()
        return nickView
    }()
    
    lazy var albumView: PAAlbumView = {
        let albumView = PAAlbumView(frame: self.view.bounds)
        return albumView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(nickView)
        nickView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nickView.block = { [weak self] in
            self?.saveNickInfo()
        }
        nickView.block1 = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        nickView.block2 = {
            NotificationCenter.default.post(name: Notification.Name(ROOT_VC), object: nil, userInfo: ["login": "1"])
        }
        nickView.block3 = { [weak self] in
            self?.popAlubum()
        }
        nickView.block4 = { [weak self] sex in
            self?.recipecalled = sex
        }
    }
    
}


extension PANickViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func popAlubum() {
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
        PARequestManager.shared.uploadAPI(params: [:], pageUrl: "/sicch/headImg", method: .post, data: data, complete: { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<BearuftModel>.deserializeFrom(dict: baseModel.shepointed) {
                    self?.nickView.imageBtn.setImage(image, for: .normal)
                    self?.picUrl = model.bearuft ?? ""
                }
            }
            ViewHud.hideLoadView()
        }, errorBlock: { error in
            ViewHud.hideLoadView()
        }, type: "image")
    }
    
    func saveNickInfo() {
        let nickStr = nickView.phoneText.text ?? ""
        if picUrl.isEmpty {
            MBProgressHUD.wj_showPlainText("Please upload your avatar.", view: nil)
        }else if nickStr.isEmpty {
            MBProgressHUD.wj_showPlainText("Please enter your nickname.", view: nil)
        }else {
            save()
        }
    }
    
    func save() {
        ViewHud.addLoadView()
        let dict = ["clank": nickView.phoneText.text ?? "", "recipecalled": recipecalled]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/afterHedidnt", method: .post) { baseModel in
            let handsto = baseModel.handsto
            let jiffy = baseModel.jiffy
            if handsto == 0 || handsto == 00 {
                NotificationCenter.default.post(name: Notification.Name(ROOT_VC), object: nil, userInfo: ["login": "1"])
            }
            ViewHud.hideLoadView()
            MBProgressHUD.wj_showPlainText(jiffy ?? "", view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
}

