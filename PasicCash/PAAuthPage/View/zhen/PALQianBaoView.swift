//
//  PALQianBaoView.swift
//  PasicCash
//
//  Created by apple on 2024/7/16.
//

import UIKit
import BRPickerView

class PALQianBaoView: PACommonView {
    
    var modelArray: [soundsModel]?
    
    var block1: ((UITextField, soundsModel) -> Void)?
    
    var block2: (() -> Void)?
    
    var block3: ((UIButton) -> Void)?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.ppaix()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(PAInputCell.self, forCellReuseIdentifier: "PAInputCell")
        tableView.register(PASelectCell.self, forCellReuseIdentifier: "PASelectCell")
        tableView.register(PADianziQinabaoCell.self, forCellReuseIdentifier: "PADianziQinabaoCell")
        return tableView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 24.ppaix())
        nextBtn.adjustsImageWhenHighlighted = false
        nextBtn.setBackgroundImage(UIImage(named: "Group_1095"), for: .normal)
        nextBtn.setTitle("Save", for: .normal)
        nextBtn.addTarget(self, action: #selector(nextClick), for: .touchUpInside)
        return nextBtn
    }()
    
    lazy var changeBtn: UIButton = {
        let changeBtn = UIButton(type: .custom)
        changeBtn.adjustsImageWhenHighlighted = false
        changeBtn.setBackgroundImage(UIImage(named: "Slicebank"), for: .normal)
        changeBtn.addTarget(self, action: #selector(changeBtnClick(_ :)), for: .touchUpInside)
        return changeBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        addSubview(changeBtn)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(scrollView.snp.top)
        }
        changeBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(23.ppaix())
            make.bottom.equalToSuperview().offset(-25.ppaix())
            make.size.equalTo(CGSize(width: 60.ppaix(), height: 60.ppaix()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PALQianBaoView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 110.ppaix()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if modelArray != nil  {
            let bgView = UIView()
            bgView.addSubview(nextBtn)
            nextBtn.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(30.ppaix())
                make.size.equalTo(CGSize(width: 305.ppaix(), height: 60.ppaix()))
            }
            return bgView
        }else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = modelArray?[indexPath.row]
        let typeStr = model?.taffeta
        let cordial = model?.cordial ?? ""
        if typeStr == "rou1" || typeStr == "rou3" {
            if model?.handsto == "crook" && cordial.contains("wallet") {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "PADianziQinabaoCell") as? PADianziQinabaoCell {
                    cell.backgroundColor = .clear
                    cell.selectionStyle = .none
                    cell.model = model
                    cell.block = { [weak self] inputField, icon1 in
                        guard let model = model else { return }
                        if model.handsto == "snowing" || model.handsto == "overcoatwas" {
                            self?.block1?(inputField, model)
                        }else {
                            self?.popOneView(textField: inputField, model: model, icon: icon1)
                        }
                    }
                    return cell
                }
            }else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "PASelectCell") as? PASelectCell {
                    cell.backgroundColor = .clear
                    cell.selectionStyle = .none
                    cell.model = model
                    cell.block = { [weak self] inputField in
                        guard let model = model else { return }
                        if model.handsto == "snowing" || model.handsto == "overcoatwas" {
                            self?.block1?(inputField, model)
                        }else {
                            self?.popOneView(textField: inputField, model: model, icon: UIImageView())
                        }
                    }
                    return cell
                }
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PAInputCell") as? PAInputCell {
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                cell.model = model
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension PALQianBaoView {
    
    @objc func nextClick() {
        self.block2?()
    }
    
    func popOneView(textField: UITextField, model: soundsModel, icon: UIImageView) {
        setupPickerView(model: model, textField: textField, icon: icon)
    }
    
    func setupPickerView(model: soundsModel, textField: UITextField, icon: UIImageView) {
        guard let brids = model.birds else { return }
        let stringPickerView = BRAddressPickerView()
        if model.taffeta == "rou1" {
            if model.handsto == "snowed" {
                stringPickerView.pickerMode = .city
                let bridsArray = erjiModel.geterjiArr(dataSourceArr: brids)
                stringPickerView.dataSourceArr = bridsArray
            }else {
                stringPickerView.pickerMode = .province
                let bridsArray = yijiModel.getyijiArr(dataSourceArr: brids)
                stringPickerView.dataSourceArr = bridsArray
            }
        }
        stringPickerView.title = model.cordial ?? ""
        stringPickerView.selectIndexs = [0]
        stringPickerView.resultBlock = { province, city, area in
            textField.font = UIFont(name: LilitaOneFont, size: 20.ppaix())
            textField.tintColor = UIColor.init(hex: "#0CE094")
            let cityName: String = city?.name ?? ""
            let provinceName: String = province?.name ?? ""
            if cityName.isEmpty {
                textField.text = provinceName
                icon.kf.setImage(with: URL(string: province?.picUrl ?? ""))
                model.goneup = province?.code
            }else {
                textField.text = provinceName + " - " + cityName
                model.goneup = (province?.code ?? "") + " | " + (city?.code ?? "")
            }
        }
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = UIColor.init(hex: "#F4FDDA")
        customStyle.pickerTextFont = UIFont(name: LilitaOneFont, size: 18.ppaix())
        customStyle.selectRowTextFont = customStyle.pickerTextFont
        customStyle.selectRowTextColor = UIColor.init(hex: "#0CE094")
        stringPickerView.pickerStyle = customStyle
        stringPickerView.show()
    }
    
    @objc func changeBtnClick(_ sender: UIButton) {
        self.block3?(sender)
    }
    
}
