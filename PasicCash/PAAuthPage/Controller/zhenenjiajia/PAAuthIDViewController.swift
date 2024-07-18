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
import BRPickerView

class PAAuthIDViewController: PABaseViewController {
    
    var productID: String?
    
    var typeModel: undressModel?
    
    var picUrl: String = ""
    
    var startime: String = ""
    
    lazy var albumView: PAAlbumView = {
        let albumView = PAAlbumView(frame: self.view.bounds)
        return albumView
    }()
    
    lazy var popView: PAPopNameView = {
        let popView = PAPopNameView(frame: self.view.bounds)
        return popView
    }()
    
    lazy var idView: PAAuthIDView = {
        let idView = PAAuthIDView()
        idView.titleLabel.text = "Validation"
        if productID != "2" {
            let attributedString = NSMutableAttributedString(string: "Start")
            attributedString.addAttribute(.foregroundColor, value: UIColor.init(hex: "#FEE610") , range: NSRange(location: 0, length: 5))
            idView.nextBtn.setAttributedTitle(attributedString, for: .normal)
        }
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
            self?.navigationController?.popToRootViewController(animated: true)
        }
        idView.block1 = { [weak self] in
            if let picUrl = self?.picUrl, picUrl.isEmpty {
                self?.popPhotot()
            } else {
                let viewController = PAFaceViewController()
                viewController.productID = self?.productID ?? ""
                PATabBarManager.hideTabBar()
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        idView.block2 = { [weak self] in
            self?.popPhotot()
        }
        idView.icon3.kf.setImage(with: URL(string: typeModel?.lively ?? ""), placeholder: UIImage(named: "Group_1031"))
        huoquyonghuxinxi()
    }
}


extension PAAuthIDViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func huoquyonghuxinxi() {
        PARequestManager.shared.requestAPI(params: [:], pageUrl: "/sicch/whatArYour", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                if let model = JSONDeserializer<shepointedModel>.deserializeFrom(dict: baseModel.shepointed), let nickModel = model.overcoat {
                    let blueFine = nickModel.blueFine ?? ""
                    self?.picUrl = blueFine
                    if !blueFine.isEmpty {
                        self?.idView.icon3.kf.setImage(with: URL(string: nickModel.blueFine ?? ""))
                    }
                }
            }
            ViewHud.hideLoadView()
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
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
            dict["goneup"] = "11"
            dict["affairs"] = productID
            dict["burst"] = "1"
            dict["stairs"] = typeModel?.goneup
        }
        PARequestManager.shared.uploadAPI(params: dict, pageUrl: apiUrl, method: .post, data: data, complete: { [weak self] baseModel in
            let handsto = baseModel.handsto
            let jiffy = baseModel.jiffy ?? ""
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
                    if self?.productID == "2" {
                        self?.idView.icon3.kf.setImage(with: URL(string: model.lively ?? ""), options: options)
                    }else {
                        self?.idView.icon3.kf.setImage(with: URL(string: model.nightwas ?? ""), options: options, completionHandler: { _ in
                            DelayUtils.delay(0.25) {
                                self?.popName(model: model)
                            }
                        })
                    }
                }
            }else {
                MBProgressHUD.wj_showPlainText(jiffy, view: nil)
            }
            ViewHud.hideLoadView()
        }, errorBlock: { error in
            ViewHud.hideLoadView()
        }, type: "image")
    }
    
    func popName(model: shepointedModel) {
        let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)
        self.popView.textFi1.text = model.hoses ?? ""
        self.popView.textFi2.text = model.mattress ?? ""
        let dateStr = (model.tthey ?? "") + "-" + (model.truck ?? "") + "-" + (model.acrowd ?? "")
        self.popView.dateBtn.setTitle(dateStr, for: .normal)
        self.present(alertVc!, animated: true)
        popView.block = { [weak self] in
            self?.dismiss(animated: true, completion: {
                self?.saveNameInfo()
            })
        }
        popView.block1 = { [weak self] in
            self?.datePop(time: self?.popView.dateBtn.titleLabel?.text ?? "")
        }
    }
    
    func datePop(time: String) {
        let datePickerView = BRDatePickerView()
        datePickerView.pickerMode = .YMD
        datePickerView.title = "Date of Birth"
        let array = time.components(separatedBy: "-").compactMap { Int($0) }
        if array.count == 3 {
            datePickerView.selectDate = NSDate.br_setYear(array[2], month: array[1], day: array[0])
        }
        datePickerView.minDate = NSDate.br_setYear(1900, month: 10, day: 1)
        datePickerView.maxDate = Date()
        datePickerView.resultBlock = { [weak self] selectDate, selectValue in
            guard let selectValue = selectValue else { return }
            let timeArray = selectValue.components(separatedBy: "-")
            if timeArray.count == 3 {
                let dateStr = "\(timeArray[2])-\(timeArray[1])-\(timeArray[0])"
                self?.popView.dateBtn.setTitle(dateStr, for: .normal)
            }
        }
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = UIColor(hex: "#F4FDDA")
        customStyle.pickerTextFont = UIFont(name: LilitaOneFont, size: 18.ppaix())
        customStyle.selectRowTextFont = customStyle.pickerTextFont
        customStyle.selectRowTextColor = UIColor(hex: "#0CE094")
        datePickerView.pickerStyle = customStyle
        datePickerView.show()
    }
    
    func saveNameInfo() {
        ViewHud.addLoadView()
        let array = popView.dateBtn.titleLabel?.text?.components(separatedBy: "-")
        let dateStr = String(format: "%@-%@-%@", array?[2] ?? "",array?[1] ?? "",array?[0] ?? "")
        let dict = ["shouts": dateStr,
                    "mattress": popView.textFi2.text ?? "",
                    "hoses": popView.textFi1.text ?? "",
                    "goneup": "11",
                    "stairs": typeModel?.goneup ?? "",
                    "spewing": "11",]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/lookinWorked", method: .post) { [weak self] baseModel in
            let handsto = baseModel.handsto
            let jiffy = baseModel.jiffy ?? ""
            if handsto == 0 || handsto == 00 {
                let faceVc = PAFaceViewController()
                faceVc.productID = self?.productID
                self?.navigationController?.pushViewController(faceVc, animated: true)
            }
            ViewHud.hideLoadView()
            MBProgressHUD.wj_showPlainText(jiffy, view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
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
