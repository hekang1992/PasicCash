//
//  PALianxiView.swift
//  Pesoin
//
//  Created by apple on 2024/7/15.
//

import UIKit
import BRPickerView

class PALianxiView: PACommonView {
    
    var modelArray: [plantsModel]?
    
    var block2: (([[String: Any]]) -> Void)?
    
    var block1: ((plantsModel, UILabel, UILabel) -> Void)?
    
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
        tableView.register(PALianxiCell.self, forCellReuseIdentifier: "PALianxiCell")
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


extension PALianxiView: UITableViewDelegate, UITableViewDataSource {
    
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
        if modelArray != nil {
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PALianxiCell") as? PALianxiCell {
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            if let model = modelArray?[indexPath.row] {
                cell.model = model
                cell.block = { [weak self] btn in
                    self?.setupPickerView(model: model, btn: btn)
                }
                cell.block1 = { [weak self] model, label1, label2 in
                    self?.block1?(model, label1, label2)
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func nextClick() {
        let array = self.modelArray?.map({ model in
            var partialResult: [String: Any] = [:]
            partialResult["erected"] = model.erected ?? ""
            partialResult["hoses"] = model.hoses ?? ""
            partialResult["direst"] = model.direst ?? ""
            partialResult["heavyoak"] = model.heavyoak ?? ""
            return partialResult
        })
        if let array = array {
            self.block2?(array)
        }
    }
    
    func setupPickerView(model: plantsModel, btn: UIButton) {
        guard let brids = model.phrase else { return }
        let stringPickerView = BRAddressPickerView()
        stringPickerView.pickerMode = .province
        let bridsArray = yijiModel.getyijiArr(dataSourceArr: brids)
        stringPickerView.dataSourceArr = bridsArray
        stringPickerView.title = model.forcovering ?? ""
        stringPickerView.selectIndexs = [0]
        stringPickerView.resultBlock = { province, city, area in
            btn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 20.ppaix())
            btn.setTitleColor(UIColor.init(hex: "#0CE094"), for: .normal)
            let provinceName: String = province?.name ?? ""
            btn.setTitle(provinceName, for: .normal)
            model.direst = province?.code
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


