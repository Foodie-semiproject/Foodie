//
//  Restaurant.swift
//  Foodie
//
//  Created by heyji on 1/7/25.
//

import Foundation

struct Restaurant: Codable {
    let name_en: String
    let address_en: String
    let type_en: String
    let review_score: Double
    let open_time_en: String
    let phone_num: String
    let homepage: String
    let reviews_en: [String]
    let summary_reviews_en: String
    let description_en: String
}
