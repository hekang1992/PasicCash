//
//  PAYouHuiQuanView.swift
//  PasicCash
//
//  Created by apple on 2024/7/10.
//

import UIKit

class PAYouHuiQuanView: PACommonView {
    
    lazy var bgIcon: UIImageView = {
        let bgIcon = UIImageView()
        bgIcon.image = UIImage(named: "Group_1020")
        return bgIcon
    }()
    
    lazy var nameLabel: UILabel = {
        let titleLabel = UILabel.createLabel(font: UIFont(name: LilitaOneFont, size: 18.pix())!, textColor: UIColor.init(hex: "#1E230F"), textAlignment: .center)
        titleLabel.text = "Discount Coupon"
        return titleLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.createLabel(font: UIFont(name: LilitaOneFont, size: 16.pix())!, textColor: UIColor.init(hex: "#0CE094"), textAlignment: .center)
        descLabel.text = "Hurry up! Your coupon is about to expire. Don’t miss out!"
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel.createLabel(font: UIFont(name: LilitaOneFont, size: 20.pix())!, textColor: UIColor.init(hex: "#FC4C4D"), textAlignment: .center)
        timeLabel.backgroundColor = UIColor.init(hex: "#FDFFF6")
        timeLabel.layer.cornerRadius = 18.pix()
        timeLabel.layer.masksToBounds = true
        let rotationAngle = CGFloat.pi / 60
        timeLabel.transform = CGAffineTransform(rotationAngle: -rotationAngle)
        return timeLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.pix()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(youhuiCell.self, forCellReuseIdentifier: "youhuiCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(backBtn)
        bgView.addSubview(bgIcon)
        bgIcon.addSubview(nameLabel)
        bgIcon.addSubview(descLabel)
        bgIcon.addSubview(timeLabel)
        addSubview(tableView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(52.pix())
            make.height.equalTo(23.pix())
        }
        backBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50.pix())
            make.left.equalToSuperview().offset(25.pix())
            make.size.equalTo(CGSize(width: 30.pix(), height: 30.pix()))
        }
        bgIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(375.pix())
            make.height.equalTo(201.pix())
            make.top.equalTo(backBtn.snp.bottom).offset(24.pix())
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(66.pix())
            make.bottom.equalToSuperview().offset(-23.pix())
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(descLabel.snp.top).offset(-20.pix())
            make.height.equalTo(21.pix())
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28.pix())
            make.size.equalTo(CGSize(width: 100.pix(), height: 35.pix()))
            make.right.equalToSuperview().offset(-56.pix())
        }
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.bottom.equalToSuperview()
            make.top.equalTo(bgIcon.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var array: [cashClasModel]? {
        didSet {
            if let array = array, !array.isEmpty {
                let model = array[0]
                if let date = DateConverter.date(from: model.flowFind ?? "") {
                    CountdownManager.startCountdown(startDate: date) { [weak self] hours, minutes, seconds in
                        DispatchQueue.main.async {
                            self?.timeLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                        }
                    }
                }
            }
        }
    }
    
}

extension PAYouHuiQuanView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = array?.count
        return count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "youhuiCell", for: indexPath) as? youhuiCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.model = array?[indexPath.row]
        return cell
    }
}

class youhuiCell: UITableViewCell {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "Group_1014")
        return bgImageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.createLabel(font: UIFont(name: LilitaOneFont, size: 16.pix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        titleLabel.text = "· Available for loans of"
        return titleLabel
    }()
    
    lazy var titleLabel1: UILabel = {
        let titleLabel1 = UILabel.createLabel(font: UIFont(name: LilitaOneFont, size: 16.pix())!, textColor: UIColor.init(hex: "#0CE094"), textAlignment: .left)
        return titleLabel1
    }()
    
    lazy var titleLabel2: UILabel = {
        let titleLabel2 = UILabel.createLabel(font: UIFont(name: LilitaOneFont, size: 16.pix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        titleLabel2.text = "· Valid until"
        return titleLabel2
    }()
    
    lazy var titleLabel3: UILabel = {
        let titleLabel3 = UILabel.createLabel(font: UIFont(name: LilitaOneFont, size: 16.pix())!, textColor: UIColor.init(hex: "#0CE094"), textAlignment: .left)
        return titleLabel3
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(titleLabel)
        bgImageView.addSubview(titleLabel1)
        bgImageView.addSubview(titleLabel2)
        bgImageView.addSubview(titleLabel3)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 321.pix(), height: 101.pix()))
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10.pix())
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17.pix())
            make.left.equalToSuperview().offset(118.pix())
            make.height.equalTo(18.pix())
        }
        titleLabel1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(126.pix())
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(18.pix())
        }
        titleLabel2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64.pix())
            make.left.equalToSuperview().offset(118.pix())
            make.height.equalTo(18.pix())
        }
        titleLabel3.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64.pix())
            make.left.equalTo(titleLabel2.snp.right).offset(4.pix())
            make.height.equalTo(18.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: cashClasModel? {
        didSet {
            guard let model = model else { return }
            titleLabel1.text = model.geminiFlas
            titleLabel3.text = model.turbo
        }
    }
    
}