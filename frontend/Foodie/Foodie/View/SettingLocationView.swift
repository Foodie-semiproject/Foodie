//
//  SettingLocationView.swift
//  Foodie
//
//  Created by heyji on 1/3/25.
//

import UIKit
import SnapKit

final class SettingLocationView: UIView {
    
//    private let locationSettingView: UIView = {
//        let view = UIView()
//        return view
//    }()
    
    private let settingLocationImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "location"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    var settingLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "위치 권한을 설정해주세요."
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var settingLocationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [settingLocationImageView, settingLocationLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(settingLocationStackView)
        
        settingLocationImageView.snp.makeConstraints { make in
            make.width.height.equalTo(18)
        }
        
        settingLocationStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        
        
    }
    
}
