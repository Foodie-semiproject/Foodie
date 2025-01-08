//
//  SummaryCell.swift
//  Foodie
//
//  Created by heyji on 1/7/25.
//

import UIKit

final class SummaryCell: UITableViewCell {
    
    static let identifier: String = "SummaryCell"
    
    private let cellView: UIView = {
        let view = UIView()
        return view
    }()

    var reviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
//        label.textColor = .black
//        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
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
    
    func configure(title: String, textColor: UIColor, linebreakMode: NSLineBreakMode = .byWordWrapping) {
        reviewLabel.text = title
        reviewLabel.textColor = textColor
        reviewLabel.lineBreakMode = linebreakMode
    }
    
    private func setupCell() {
        contentView.addSubview(cellView)
        cellView.addSubview(reviewLabel)
        cellView.addSubview(seperatorView)
        
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        reviewLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        seperatorView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
    }

}
