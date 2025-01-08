//
//  ReviewCell.swift
//  Foodie
//
//  Created by heyji on 1/5/25.
//

import UIKit

final class ReviewCell: UITableViewCell {
    
    static let identifier: String = "ReviewCell"
    
    private let cellView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = .systemGray
        return imageView
    }()

    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        reviewLabel.text = title
    }
    
    private func setupCell() {
        contentView.addSubview(cellView)
        cellView.addSubview(profileImageView)
        cellView.addSubview(reviewLabel)
        
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }
        reviewLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.equalTo(profileImageView.snp.right).offset(8)
            make.right.equalToSuperview().inset(16)
        }
    }

}
