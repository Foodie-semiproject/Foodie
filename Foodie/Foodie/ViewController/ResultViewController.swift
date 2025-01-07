//
//  ResultViewController.swift
//  Foodie
//
//  Created by heyji on 1/5/25.
//

import UIKit
import SnapKit

final class ResultViewController: UIViewController {
    
    private let resultView = ResultView()
    var image: UIImage = UIImage()
    var restaurantName: String = ""
    
    private let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .black
        indicator.style = .large
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        return indicator
    }()
    
//    var restaurantInfo: Restaurant?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        networkRequest()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(resultView)
        self.view.addSubview(indicatorView)
        resultView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        indicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.view.bringSubviewToFront(indicatorView)
    }
    
    private func networkRequest() {
        indicatorView.startAnimating()
        Network.shared.getRestaurants(query: restaurantName) { restaurantInfo in
            
            print(restaurantInfo.summary_reviews_en)
            
            DispatchQueue.main.async {
                self.indicatorView.stopAnimating()
                self.resultView.configure(image: self.image, title: restaurantInfo.name, subTitle: restaurantInfo.type, location: restaurantInfo.address, openTime: restaurantInfo.open_time, phone: restaurantInfo.phone_num, homepage: restaurantInfo.homepage, description: restaurantInfo.description, summaryReview: restaurantInfo.summary_reviews_en, reviewList: restaurantInfo.reviews)
            }
            
            if RestaurantStorage.shared.addRestaurant(restaurantInfo) {
                print("레스토랑이 성공적으로 저장되었습니다.")
            } else {
                print("이미 존재하는 레스토랑입니다.")
            }
        }
    }
    
}
