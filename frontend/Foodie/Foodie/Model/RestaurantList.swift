//
//  RestaurantList.swift
//  Foodie
//
//  Created by heyji on 1/8/25.
//

import Foundation

struct RestaurantList: Codable {
    let name: String
    let address: String
    let type: String
    let review_score: Double
    let open_time: String
    let phone_num: String
    let homepage: String
    let reviews: [String]
    let summary_reviews: String
    let description: String
    let gemini_translation: [String]
}
