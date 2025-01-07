//
//  Restaurant.swift
//  Foodie
//
//  Created by heyji on 1/7/25.
//

import Foundation

struct Restaurant: Codable {
    let name: String
    let address: String
    let type: String
    let review_score: Double
    let open_time: String
    let phone_num: String
    let homepage: String
    let reviews: [String]
    let summary_reviews_en: String
    let description: String
}
