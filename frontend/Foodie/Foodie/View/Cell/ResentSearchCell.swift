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
        stackView.spacing = 6
        stackView.alignment = .leading
        return stackView
    }()
    
    private var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    private var reviewView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var summaryReviewLabel: UILabel = {
        let label = UILabel()
        label.text = "The staff is friendly and the atmosphere is good. In particular, there are opinions that the friendly service of the owner, the taste of the food, and the taste of the alcohol are satisfying, so there is an intention to revisit. "
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
//        label.lineBreakMode = .byCharWrapping
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
    
    func configure(title: String, subTitle: String, location: String, openTime: String, phone: String, homepage:String, summaryReview: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
        locationLabel.text = location
        openTimeLabel.text = openTime
        telephoneLabel.text = phone
        homepageLabel.text = homepage
        summaryReviewLabel.text = summaryReview
    }
    
    private func setupCell() {
        addSubview(cellView)
        cellView.addSubview(titleStackView)
        cellView.addSubview(descriptionStackView)
        cellView.addSubview(seperatorView)
        cellView.addSubview(reviewView)
        reviewView.addSubview(summaryReviewLabel)
        
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
            make.top.equalTo(titleStackView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(12)
        }
        seperatorView.snp.makeConstraints { make in
            make.top.equalTo(descriptionStackView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(12)
            make.height.equalTo(1)
        }
        reviewView.snp.makeConstraints { make in
            make.top.equalTo(seperatorView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
        summaryReviewLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
    
}
