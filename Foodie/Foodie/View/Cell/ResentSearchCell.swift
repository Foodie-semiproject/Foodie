//
//  ResentSearchCell.swift
//  Foodie
//
//  Created by heyji on 1/5/25.
//

import UIKit

final class ResentSearchCell: UICollectionViewCell {
    
    static let identifier: String = "ResentSearchCell"
    
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = false
//        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
//        view.layer.shadowOffset = .zero
//        view.layer.shadowOpacity = 1
        return view
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
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.text = "서울 강남구 역삼동 123-456"
        return label
    }()
    
    lazy var locationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationImageView, locationLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    private let openTimeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "clock.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    var openTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
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
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    var telephoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
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
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    var homepageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
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
        stackView.alignment = .leading
        return stackView
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "국내외에서 이름을 드높이고 있는 강민구 셰프의 뉴코리안 레스토랑. 사찰음식과 한식 장인에게 전수받은 전통 한식 기법을 현대적으로 재해석한 한식을 맛볼 수 있다. 완벽을 지향하는 육수 내기 등 기본기를 중요시하고 있다. 실내 분위기도 모던하고 쾌적하며 서비스도 나무랄 데 없다. 2020년에 홍콩에 오픈한 한식당 한식구가 큰 인기를 끄는 등 글로벌 셰프로서의 위엄을 보여준다."
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.lineBreakStrategy = .hangulWordPriority
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, subTitle: String, location: String, openTime: String, phone: String, homepage:String, description: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
        locationLabel.text = location
        openTimeLabel.text = openTime
        telephoneLabel.text = phone
        homepageLabel.text = homepage
        descriptionLabel.text = description
    }
    
    private func setupCell() {
        addSubview(cellView)
        cellView.addSubview(titleStackView)
        cellView.addSubview(descriptionStackView)
        cellView.addSubview(descriptionLabel)
        
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.setContentHuggingPriority(.init(251), for: .horizontal)
        subTitleLabel.setContentHuggingPriority(.init(250), for: .horizontal)
        titleStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        descriptionStackView.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(12)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionStackView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
}
