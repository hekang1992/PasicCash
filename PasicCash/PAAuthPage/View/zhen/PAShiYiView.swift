//
//  PAShiYiView.swift
//  PasicCash
//
//  Created by apple on 2024/7/13.
//

import UIKit
import Kingfisher

class PAShiYiView: PACommonView {
    
    var array: [undressModel]?
    
    var block1: ((undressModel) -> Void)?

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
        tableView.register(cardTypeCell.self, forCellReuseIdentifier: "cardTypeCell")
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PAShiYiView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cardTypeCell", for: indexPath) as? cardTypeCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.model = array?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = array?[indexPath.row] {
            self.block1?(model)
        }
    }
    
}

class cardTypeCell: UITableViewCell {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.borderWidth = 2.ppaix()
        bgView.layer.cornerRadius = 20.ppaix()
        bgView.layer.borderColor = UIColor.init(hex: "#FFFFFF").cgColor
        return bgView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        nameLabel.numberOfLines = 0
        nameLabel.text = "342r"
        return nameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgView.addSubview(nameLabel)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.ppaix())
            make.top.equalToSuperview()
            make.height.equalTo(100.ppaix())
            make.bottom.equalToSuperview().offset(-20.ppaix())
        }
        bgImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20.ppaix())
            make.size.equalTo(CGSize(width: 129.ppaix(), height: 79.ppaix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(bgImageView.snp.right).offset(20.ppaix())
            make.right.equalToSuperview().offset(-20.ppaix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: undressModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.goneup
            bgImageView.kf.setImage(with: URL(string: model.lively ?? ""))
        }
    }
    
}
