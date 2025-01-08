//
//  HomeView.swift
//  Foodie
//
//  Created by heyji on 12/18/24.
//

import UIKit

final class HomeView: UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    let cameraButton: UIButton = {
        let button = UIButton()
        button.setTitle("간판 이미지 촬영하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "상호명 : "
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(imageView)
        addSubview(cameraButton)
        addSubview(infoLabel)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
            make.width.height.equalTo(300)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.cameraButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
            make.width.equalTo(300)
        }
    }
}
