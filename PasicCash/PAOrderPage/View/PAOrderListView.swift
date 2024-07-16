//
//  PAOrderListView.swift
//  PasicCash
//
//  Created by apple on 2024/7/16.
//

import UIKit
import Kingfisher

class PAOrderListView: PACommonView {

    var modelArray: [plantsModel]?
    
    var block1: ((String) -> Void)?
    
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
        tableView.register(PAOrderCell.self, forCellReuseIdentifier: "PAOrderCell")
        return tableView
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


extension PAOrderListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.ppaix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PAOrderCell", for: indexPath) as? PAOrderCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.model = modelArray?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = modelArray?[indexPath.row] {
            self.block1?(model.shyly ?? "")
        }
    }
    
}

class PAOrderCell: UITableViewCell {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 20.ppaix()
        bgView.backgroundColor = UIColor.init(hex: "#FDFFF6")
        return bgView
    }()
    
    lazy var productImageView: UIImageView = {
        let productImageView = UIImageView()
        productImageView.layer.cornerRadius = 10.ppaix()
        productImageView.layer.masksToBounds = true
        productImageView.backgroundColor = UIColor.init(hex: "#D1F562")
        return productImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 16.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var nameLabel1: UILabel = {
        let nameLabel1 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 12.ppaix())!, textColor: UIColor.init(hex: "#C7CABB"), textAlignment: .left)
        return nameLabel1
    }()
    
    lazy var nameLabel2: UILabel = {
        let nameLabel2 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 12.ppaix())!, textColor: UIColor.init(hex: "#C7CABB"), textAlignment: .left)
        return nameLabel2
    }()
    
    lazy var nameLabel3: UILabel = {
        let nameLabel3 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 20.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        return nameLabel3
    }()
    
    lazy var nameLabel4: UILabel = {
        let nameLabel4 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 20.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        return nameLabel4
    }()
    
    lazy var repayimaegView: UIImageView = {
        let repayimaegView = UIImageView()
        return repayimaegView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(productImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(nameLabel1)
        bgView.addSubview(nameLabel2)
        bgView.addSubview(nameLabel3)
        bgView.addSubview(nameLabel4)
        bgView.addSubview(repayimaegView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(15.ppaix())
            make.height.equalTo(105.ppaix())
            make.bottom.equalToSuperview().offset(-20.ppaix())
        }
        productImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10.ppaix())
            make.top.equalToSuperview().offset(10.ppaix())
            make.size.equalTo(CGSize(width: 20.ppaix(), height: 20.ppaix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(productImageView.snp.right).offset(10.ppaix())
            make.centerY.equalTo(productImageView.snp.centerY)
            make.height.equalTo(18.5.ppaix())
        }
        nameLabel1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.ppaix())
            make.top.equalTo(nameLabel.snp.bottom).offset(19.ppaix())
            make.height.equalTo(13.5.ppaix())
        }
        nameLabel2.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(19.ppaix())
            make.height.equalTo(13.5.ppaix())
            make.left.equalToSuperview().offset(120.ppaix())
        }
        nameLabel3.snp.makeConstraints { make in
            make.left.equalTo(nameLabel1.snp.left)
            make.top.equalTo(nameLabel1.snp.bottom).offset(5.ppaix())
            make.height.equalTo(23.ppaix())
        }
        nameLabel4.snp.makeConstraints { make in
            make.left.equalTo(nameLabel2.snp.left)
            make.top.equalTo(nameLabel2.snp.bottom).offset(5.ppaix())
            make.height.equalTo(23.ppaix())
        }
        repayimaegView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50.ppaix())
            make.size.equalTo(CGSize(width: 70.ppaix(), height: 40.ppaix()))
            make.right.equalToSuperview().offset(-15.ppaix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: plantsModel? {
        didSet {
            guard let model = model else { return }
            productImageView.kf.setImage(with: URL(string: model.charred ?? ""))
            nameLabel.text = model.bringing
            nameLabel1.text = model.surprised
            nameLabel2.text = model.lovely
            nameLabel3.text = model.dandy
            nameLabel4.text = model.creation
            repayimaegView.kf.setImage(with: URL(string: model.saving ?? ""))
        }
    }
    
}
