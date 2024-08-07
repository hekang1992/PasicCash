//
//  PABigCardView.swift
//  Pesoin
//
//  Created by apple on 2024/7/5.
//

import UIKit
import Kingfisher
import GKCycleScrollView

class PABigCardView: UIView {
    
    var bannerModel: LikethatModel?
    
    var bigModel: saidjemModel?
    
    var authModel: andcreptModel?
    
    var secModel: credentialModel?
    
    var reqImgModel: reqModel?
    
    var rankModel: reqModel?
    
    var expandedIndexPaths = Set<IndexPath>()
    
    var block: ((String) -> Void)?
    
    var block1: (() -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
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
        tableView.register(PABannerCell.self, forCellReuseIdentifier: "PABannerCell")
        tableView.register(PABigCardCell.self, forCellReuseIdentifier: "PABigCardCell")
        tableView.register(PAAuthCell.self, forCellReuseIdentifier: "PAAuthCell")
        tableView.register(PASecCell.self, forCellReuseIdentifier: "PASecCell")
        tableView.register(PARankCell.self, forCellReuseIdentifier: "PARankCell")
        tableView.register(PARankDescCell.self, forCellReuseIdentifier: "PARankDescCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(tableView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradient()
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 60.ppaix(), right: 0))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PABigCardView: UITableViewDelegate, UITableViewDataSource {
    
    func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bgView.bounds
        gradientLayer.colors = [
            UIColor.init(hex: "#B7EC2B").cgColor,
            UIColor.init(hex: "#FCFFF2").cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.92, y: 0.08)
        gradientLayer.endPoint = CGPoint(x: 0.92, y: 0.92)
        self.bgView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (0...4).contains(section) {
            return 1
        } else {
            return rankModel?.danger?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? PARankDescCell
        if indexPath.section > 4 {
            if expandedIndexPaths.contains(indexPath) {
                expandedIndexPaths.remove(indexPath)
                cell?.eyeImageView.image = UIImage(named: "Group_938")
            } else {
                expandedIndexPaths.insert(indexPath)
                cell?.eyeImageView.image = UIImage(named: "Group_935")
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if expandedIndexPaths.contains(indexPath) {
            return 125.ppaix()
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.section
        let row = indexPath.row
        switch (index, row) {
        case (0, 0):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PABannerCell", for: indexPath) as? PABannerCell {
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                cell.model = bannerModel
                return cell
            }
        case (1, 0):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PABigCardCell", for: indexPath) as? PABigCardCell {
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                cell.model = bigModel?.danger
                cell.applyBlock = { [weak self] in
                    self?.block?(self?.bigModel?.danger?.formy ?? "")
                }
                cell.block = { [weak self] in
                    self?.block1?()
                }
                return cell
            }
        case (2, 0):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PAAuthCell", for: indexPath) as? PAAuthCell {
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                cell.model = authModel
                return cell
            }
        case (3, 0):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PASecCell", for: indexPath) as? PASecCell {
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                cell.model = secModel?.danger?[0]
                return cell
            }
        case (4, 0):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PARankCell", for: indexPath) as? PARankCell {
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                cell.model = reqImgModel?.danger?[0]
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PARankDescCell", for: indexPath) as? PARankDescCell {
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                cell.model = rankModel?.danger?[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
    
}

class PABannerCell: UITableViewCell, GKCycleScrollViewDataSource, GKCycleScrollViewDelegate {
    
    lazy var bannerView: GKCycleScrollView = {
        let bannerView = GKCycleScrollView()
        bannerView.delegate = self
        bannerView.dataSource = self
        bannerView.layer.cornerRadius = 20.ppaix()
        bannerView.minimumCellAlpha = 0.0;
        return bannerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bannerView)
        bannerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(25.ppaix())
            make.top.equalToSuperview().offset(40.ppaix())
            make.height.equalTo(110.ppaix())
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfCells(in cycleScrollView: GKCycleScrollView!) -> Int {
        return model?.danger?.count ?? 0
    }
    
    func cycleScrollView(_ cycleScrollView: GKCycleScrollView, cellForViewAt index: Int) -> GKCycleScrollViewCell {
        let cell = GKCycleScrollViewCell()
        if let model = model?.danger?[index], let picUrl = model.lively {
            cell.imageView.kf.setImage(with: URL(string: picUrl))
        }
        return cell
    }
    
    func cycleScrollView(_ cycleScrollView: GKCycleScrollView, didSelectCellAt index: Int) {
        
    }
    
    var model: LikethatModel? {
        didSet {
            bannerView.reloadData()
        }
    }
    
}

class PABigCardCell: UITableViewCell {
    
    var applyBlock: (() -> Void)?
    
    var block: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = UIImage(named: "Group_1")
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 20.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var jiageLabel: UILabel = {
        let jiageLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 70.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .left)
        return jiageLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 12.ppaix())!, textColor: UIColor.init(hex: "#8D917F"), textAlignment: .left)
        return descLabel
    }()
    
    lazy var agreeBtn: UIButton = {
        let agreeBtn = UIButton(type: .custom)
        agreeBtn.setImage(UIImage(named: "Group_1035"), for: .normal)
        agreeBtn.addTarget(self, action: #selector(agreeBtnClick(_ :)), for: .touchUpInside)
        return agreeBtn
    }()
    
    lazy var agreeLabel: UILabel = {
        let agreeLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 12.ppaix())!, textColor: UIColor.init(hex: "#8D917F"), textAlignment: .left)
        let attributedText = NSMutableAttributedString(string: "I have read and agreed to the ")
        let userAgreement = NSMutableAttributedString(string: "Loan Agreement", attributes: [
            .foregroundColor: UIColor.init(hex: "#C2EF44"),
        ])
        attributedText.append(userAgreement)
        agreeLabel.attributedText = attributedText
        agreeLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userAgreementTapped))
        agreeLabel.addGestureRecognizer(tapGesture)
        return agreeLabel
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "Mask_group")
        return iconImageView
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.titleLabel?.font = UIFont(name: LilitaOneFont, size: 24.ppaix())
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.isEnabled = false
        applyBtn.setBackgroundImage(UIImage(named: "Group_1001"), for: .normal)
        applyBtn.addTarget(self, action: #selector(applyClick), for: .touchUpInside)
        return applyBtn
    }()
    
    lazy var descLabel1: UILabel = {
        let descLabel1 = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 8.ppaix())!, textColor: UIColor.init(hex: "#8D917F"), textAlignment: .center)
        descLabel1.text = "The actual loan amount is subject to system review."
        return descLabel1
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(jiageLabel)
        bgImageView.addSubview(descLabel)
        bgImageView.addSubview(agreeBtn)
        bgImageView.addSubview(agreeLabel)
        bgImageView.addSubview(iconImageView)
        bgImageView.addSubview(applyBtn)
        bgImageView.addSubview(descLabel1)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.ppaix(), height: 450.ppaix()))
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(56.ppaix())
            make.top.equalToSuperview().offset(36.ppaix())
            make.height.equalTo(23.ppaix())
        }
        jiageLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(55.ppaix())
            make.top.equalTo(nameLabel.snp.bottom).offset(30.ppaix())
            make.height.equalTo(80.ppaix())
        }
        descLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(56.ppaix())
            make.top.equalTo(jiageLabel.snp.bottom).offset(10.ppaix())
            make.height.equalTo(14.ppaix())
        }
        agreeBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(42.ppaix())
            make.top.equalTo(descLabel.snp.bottom).offset(56.ppaix())
            make.size.equalTo(CGSize(width: 28.ppaix(), height: 28.ppaix()))
        }
        agreeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(agreeBtn.snp.centerY)
            make.left.equalTo(agreeBtn.snp.right)
            make.height.equalTo(14.ppaix())
        }
        iconImageView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalTo(agreeLabel.snp.top)
            make.size.equalTo(CGSize(width: 100.ppaix(), height: 105.ppaix()))
        }
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(agreeLabel.snp.bottom).offset(15.5.ppaix())
            make.size.equalTo(CGSize(width: 263.ppaix(), height: 52.ppaix()))
        }
        descLabel1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(applyBtn.snp.bottom).offset(5.ppaix())
            make.height.equalTo(9.ppaix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: dangerModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.amber
            jiageLabel.text = model.gazingat
            formatLabel(descLabel, withText: model.theblanket ?? "", color: UIColor.init(hex: "#0F816A"))
            applyBtn.setTitle(model.settin, for: .normal)
        }
    }
    
    func formatLabel(_ label: UILabel, withText text: String, color: UIColor) {
        let attributedText = NSMutableAttributedString(string: text)
        if let startRange = text.range(of: "Only"), let endRange = text.range(of: "pesos") {
            let startIndex = text.distance(from: text.startIndex, to: startRange.upperBound)
            let endIndex = text.distance(from: text.startIndex, to: endRange.lowerBound)
            let range = NSRange(location: startIndex, length: endIndex - startIndex)
            attributedText.addAttribute(.foregroundColor, value: color, range: range)
        }
        label.attributedText = attributedText
    }
    
    @objc func agreeBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            applyBtn.isEnabled = true
            sender.setImage(UIImage(named: "Group_1034"), for: .normal)
        }else {
            applyBtn.isEnabled = false
            sender.setImage(UIImage(named: "Group_1035"), for: .normal)
        }
    }
    
    @objc func userAgreementTapped() {
        self.block?()
    }
    
    @objc func applyClick() {
        self.applyBlock?()
    }
    
}

class PAAuthCell: UITableViewCell, GKCycleScrollViewDelegate, GKCycleScrollViewDataSource {
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 27.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .center)
        return nameLabel
    }()
    
    lazy var rongqiView: UIView = {
        let rongqiView = UIView()
        return rongqiView
    }()
    
    lazy var bannerView: GKCycleScrollView = {
        let bannerView = GKCycleScrollView()
        bannerView.delegate = self
        bannerView.dataSource = self
        bannerView.isAutoScroll = false
        bannerView.isInfiniteLoop = false
        bannerView.minimumCellAlpha = 0.0
        bannerView.defaultSelectIndex = 1
        bannerView.leftRightMargin = 1.ppaix()
        return bannerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(rongqiView)
        rongqiView.addSubview(bannerView)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 250.ppaix(), height: 31.ppaix()))
        }
        rongqiView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(21.ppaix())
            make.top.equalTo(nameLabel.snp.bottom).offset(23.ppaix())
            make.height.equalTo(98.ppaix())
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        bannerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: andcreptModel? {
        didSet {
            if let model = model {
                bannerView.reloadData()
                nameLabel.text = model.cordial
            }
        }
    }
    
    func numberOfCells(in cycleScrollView: GKCycleScrollView!) -> Int {
        return model?.plants?.count ?? 0
    }
    
    func cycleScrollView(_ cycleScrollView: GKCycleScrollView, cellForViewAt index: Int) -> GKCycleScrollViewCell {
        let cell = AuthCell()
        if let model = model?.plants?[index], let picUrl = model.lively {
            cell.model = model
            cell.iconImageView.kf.setImage(with: URL(string: picUrl))
        }
        return cell
    }
    
    func cycleScrollView(_ cycleScrollView: GKCycleScrollView, didSelectCellAt index: Int) {
        
    }
    
    func sizeForCell(in cycleScrollView: GKCycleScrollView!) -> CGSize {
        return CGSize(width: 170.ppaix(), height: 98.ppaix())
    }
    
}

class AuthCell: GKCycleScrollViewCell {
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        return iconImageView
    }()
    
    lazy var setpLabel: UILabel = {
        let setpLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 18.ppaix())!, textColor: UIColor.init(hex: "#0F816A"), textAlignment: .center)
        return setpLabel
    }()
    
    lazy var setpLab1l: UILabel = {
        let setpLab1l = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 15.ppaix())!, textColor: UIColor.init(hex: "#0F816A"), textAlignment: .center)
        setpLab1l.numberOfLines = 0
        return setpLab1l
    }()
    
    lazy var statusImagView: UIImageView = {
        let statusImagView = UIImageView()
        statusImagView.isHidden = true
        statusImagView.image = UIImage(named: "Mask_succ")
        return statusImagView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        iconImageView.addSubview(setpLabel)
        iconImageView.addSubview(setpLab1l)
        iconImageView.addSubview(statusImagView)
        iconImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(170.ppaix())
        }
        setpLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(18.ppaix())
            make.height.equalTo(20.5.ppaix())
        }
        setpLab1l.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-18.ppaix())
            make.width.equalTo(150.ppaix())
        }
        statusImagView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 50.ppaix(), height: 50.ppaix()))
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: plantsModel? {
        didSet {
            if let model = model {
                setpLabel.text = model.eaten
                setpLab1l.text = model.cordial
                statusImagView.isHidden = model.someday == "1" ? false : true
            }
        }
    }
}

class PASecCell: UITableViewCell {
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 27.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .center)
        return nameLabel
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        return iconImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(iconImageView)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 250.ppaix(), height: 31.ppaix()))
        }
        iconImageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(2.ppaix())
            make.height.equalTo(147.ppaix())
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: dangerModel? {
        didSet {
            if let model = model {
                nameLabel.text = model.cordial
                iconImageView.kf.setImage(with: URL(string: model.lively ?? ""))
            }
        }
    }
}

class PARankCell: UITableViewCell {
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.image = UIImage(named: "Group_1003")
        return descImageView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        return iconImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 27.ppaix())!, textColor: UIColor.init(hex: "#1C200D"), textAlignment: .center)
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(descImageView)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(250.ppaix())
        }
        iconImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 175.ppaix(), height: 55.ppaix()))
            make.top.equalTo(nameLabel.snp.bottom).offset(20.ppaix())
        }
        descImageView.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(nameLabel.snp.top)
            make.size.equalTo(CGSize(width: 23.ppaix(), height: 23.ppaix()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: dangerModel? {
        didSet {
            if let model = model {
                nameLabel.text = model.cordial
                iconImageView.kf.setImage(with: URL(string: model.lively ?? ""))
            }
        }
    }
}

class PARankDescCell: UITableViewCell {
    
    var block: (() -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hex: "#FDFFF6")
        bgView.layer.cornerRadius = 20.ppaix()
        bgView.layer.borderWidth = 2.ppaix()
        bgView.layer.borderColor = UIColor.init(hex: "#C6F14D").cgColor
        return bgView
    }()
    
    lazy var rankImageView: UIImageView = {
        let rankImageView = UIImageView()
        rankImageView.contentMode = .scaleAspectFit
        return rankImageView
    }()
    
    lazy var fenshuLabel: UILabel = {
        let fenshuLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 16.ppaix())!, textColor: UIColor.init(hex: "#C6F14D"), textAlignment: .left)
        return fenshuLabel
    }()
    
    lazy var contentLabel: UILabel = {
        let contentLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 13.ppaix())!, textColor: UIColor.init(hex: "#8D917F"), textAlignment: .left)
        contentLabel.numberOfLines = 0
        return contentLabel
    }()
    
    lazy var eyeImageView: UIImageView = {
        let eyeImageView = UIImageView()
        eyeImageView.contentMode = .scaleAspectFit
        eyeImageView.image = UIImage(named: "Group_938")
        return eyeImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 13.ppaix())!, textColor: UIColor.init(hex: "#C2C8B0"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel.buildLabel(font: UIFont(name: LilitaOneFont, size: 13.ppaix())!, textColor: UIColor.init(hex: "#C2C8B0"), textAlignment: .left)
        return timeLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(rankImageView)
        bgView.addSubview(fenshuLabel)
        bgView.addSubview(contentLabel)
        bgView.addSubview(eyeImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(timeLabel)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(12.5.ppaix())
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-19.ppaix())
        }
        rankImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.ppaix())
            make.top.equalToSuperview().offset(15.ppaix())
            make.size.equalTo(CGSize(width: 120.ppaix(), height: 19.ppaix()))
        }
        fenshuLabel.snp.makeConstraints { make in
            make.left.equalTo(rankImageView.snp.right).offset(10.ppaix())
            make.top.equalTo(rankImageView.snp.top)
            make.bottom.equalTo(rankImageView.snp.bottom)
        }
        contentLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(15.ppaix())
            make.top.equalTo(fenshuLabel.snp.bottom).offset(14.ppaix())
            make.bottom.equalToSuperview().offset(-45.ppaix())
        }
        eyeImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-14.ppaix())
            make.top.equalToSuperview().offset(20.ppaix())
            make.size.equalTo(CGSize(width: 21.ppaix(), height: 21.ppaix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15.ppaix())
            make.left.equalToSuperview().offset(15.ppaix())
            make.height.equalTo(15.ppaix())
        }
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15.ppaix())
            make.right.equalToSuperview().offset(-15.ppaix())
            make.height.equalTo(15.ppaix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: dangerModel? {
        didSet {
            if let model = model {
                rankImageView.kf.setImage(with: URL(string: model.scoreImg ?? ""))
                fenshuLabel.text = model.contests
                contentLabel.text = model.feedback
                nameLabel.text = model.experienced
                timeLabel.text = model.cocoa
            }
        }
    }
    
}

