//
//  PAShiYiView.swift
//  PasicCash
//
//  Created by apple on 2024/7/13.
//

import UIKit

class PAShiYiView: PACommonView {

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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cardTypeCell", for: indexPath) as? cardTypeCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        return cell
    }
    
}

class cardTypeCell: UITableViewCell {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.borderWidth = 4.ppaix()
        bgView.layer.cornerRadius = 20.ppaix()
        bgView.layer.borderColor = UIColor.init(hex: "#FFFFFF").cgColor
        return bgView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.layer.cornerRadius = 25.ppaix()
        bgImageView.layer.masksToBounds = true
        bgImageView.image = UIImage(named: "Group_1026")
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
            make.height.equalTo(120.ppaix())
            make.bottom.equalToSuperview().offset(-20.ppaix())
        }
        bgImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20.ppaix())
            make.size.equalTo(CGSize(width: 105.ppaix(), height: 95.ppaix()))
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
    
}
