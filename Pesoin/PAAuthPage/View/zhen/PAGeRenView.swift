//
//  PAGeRenView.swift
//  Pesoin
//
//  Created by apple on 2024/7/15.
//

import UIKit
import BRPickerView

class PAGeRenView: PACommonView {
    
    var modelArray: [soundsModel]?
    
    var block1: ((UITextField, soundsModel) -> Void)?
    
    var block2: (() -> Void)?
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(scrollView.snp.top)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PAGeRenView: UITableViewDelegate, UITableViewDataSource {
    
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
        if typeStr == "rou1" || typeStr == "rou3" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PASelectCell") as? PASelectCell {
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                cell.model = model
                cell.block = { [weak self] inputField in
                    guard let model = model else { return }
                    if model.handsto == "snowing" || model.handsto == "overcoatwas" {
                        self?.block1?(inputField, model)
                    }else {
                        self?.popOneView(textField: inputField, model: model)
                    }
                }
                return cell
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

extension PAGeRenView {
    
    @objc func nextClick() {
        self.block2?()
    }
    
    func popOneView(textField: UITextField, model: soundsModel) {
        setupPickerView(model: model, textField: textField)
    }
    
    func setupPickerView(model: soundsModel, textField: UITextField) {
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
    
}
