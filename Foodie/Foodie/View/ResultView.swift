//
//  ResultView.swift
//  Foodie
//
//  Created by heyji on 1/5/25.
//

import UIKit
import SnapKit

final class ResultView: UIView {
    
    private let reviewList: [String] = ["불도장 맛집", "맛과. 서비스는 최상이나 가격대비 고급레스토랑 분위기는 아닌듯함. 통일성없는 그릇들과 인테리어 플레이팅도 깔끔한편은 아닌거같음. 무엇보다도 매장에 담배냄새가 너무심함. 다른 룸에서 담배를 피는지요... 담배냄새만. 기억에 남습니다.....", "최악이네요 가격도비싸고 맛도 없고 양도 적습니다...", "아무리 강남에 럭셔리 레스토랑이여도 1인 8만원에 탕수육 1조각반에 멘보샤 반개는.너무 하지 않나. 저게 코스의 전부인거는 넘하다", "맛과. 서비스는 최상이나 가격대비 고급레스토랑 분위기는 아닌듯함. 통일성없는 그릇들과 인테리어 플레이팅도 깔끔한편은 아닌거같음. 무엇보다도 매장에 담배냄새가 너무심함. 다른 룸에서 담배를 피는지요... 담배냄새만. 기억에 남습니다.....", "맛과. 서비스는 최상이나 가격대비 고급레스토랑 분위기는 아닌듯함. 통일성없는 그릇들과 인테리어 플레이팅도 깔끔한편은 아닌거같음. 무엇보다도 매장에 담배냄새가 너무심함. 다른 룸에서 담배를 피는지요... 담배냄새만. 기억에 남습니다.....", "맛과. 서비스는 최상이나 가격대비 고급레스토랑 분위기는 아닌듯함. 통일성없는 그릇들과 인테리어 플레이팅도 깔끔한편은 아닌거같음. 무엇보다도 매장에 담배냄새가 너무심함. 다른 룸에서 담배를 피는지요... 담배냄새만. 기억에 남습니다....."]
    
    var signboardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.text = "더 그린테이블"
        return label
    }()
    
    var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.text = "프랑스음식"
        return label
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "mappin.and.ellipse")
        return imageView
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.text = "서울 강남구 역삼동 123-456"
        return label
    }()
    
    lazy var locationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationImageView, locationLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let openTimeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "clock.fill")
        return imageView
    }()
    
    var openTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.text = "화~토 15:00 ~ 18:00"
        return label
    }()
    
    lazy var openTimeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [openTimeImageView, openTimeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let telephoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone.fill")
        return imageView
    }()
    
    var telephoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.text = "02-591-2672"
        return label
    }()
    
    lazy var telephoneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [telephoneImageView, telephoneLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let homepageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "network")
        return imageView
    }()
    
    var homepageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.text = "http://www.restaurant-mingles.com/"
        return label
    }()
    
    lazy var homepageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [homepageImageView, homepageLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationStackView, openTimeStackView, telephoneStackView, homepageStackView])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.text = "국내외에서 이름을 드높이고 있는 강민구 셰프의 뉴코리안 레스토랑. 사찰음식과 한식 장인에게 전수받은 전통 한식 기법을 현대적으로 재해석한 한식을 맛볼 수 있다. 완벽을 지향하는 육수 내기 등 기본기를 중요시하고 있다. 실내 분위기도 모던하고 쾌적하며 서비스도 나무랄 데 없다. 2020년에 홍콩에 오픈한 한식당 한식구가 큰 인기를 끄는 등 글로벌 셰프로서의 위엄을 보여준다."
        return label
    }()
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    lazy var reviewTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.identifier)
        tableView.tableHeaderView = headerView
        tableView.sectionHeaderTopPadding = .zero
        return tableView
    }()
    
    lazy var headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 520))
        view.backgroundColor = .white
        return view
    }()
    
    func configure(image: UIImage, title: String, subTitle: String, location: String, openTime: String, phone: String, homepage:String, description: String) {
        signboardImageView.image = image
        titleLabel.text = title
        subTitleLabel.text = subTitle
        locationLabel.text = location
        openTimeLabel.text = openTime
        telephoneLabel.text = phone
        homepageLabel.text = homepage
        descriptionLabel.text = description
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(reviewTableView)
        headerView.addSubview(signboardImageView)
        headerView.addSubview(titleStackView)
        headerView.addSubview(descriptionStackView)
        headerView.addSubview(descriptionLabel)
        headerView.addSubview(seperatorView)
        
        
        signboardImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.left.equalToSuperview().inset(16)
            make.height.equalTo(180)
        }
        titleStackView.snp.makeConstraints { make in
            make.top.equalTo(signboardImageView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        descriptionStackView.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionStackView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        seperatorView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        reviewTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
}

extension ResultView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier, for: indexPath) as! ReviewCell
        cell.configure(title: reviewList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        let sectionTitleLabel = UILabel()
        sectionTitleLabel.text = "리뷰"
        sectionTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        sectionTitleLabel.textColor = .black
        headerView.addSubview(sectionTitleLabel)
        sectionTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
        return headerView
    }
}
