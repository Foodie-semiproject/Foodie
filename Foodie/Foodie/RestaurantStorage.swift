//
//  RestaurantManager.swift
//  Foodie
//
//  Created by heyji on 1/7/25.
//

import Foundation

class RestaurantStorage {
    static let shared = RestaurantStorage()
    private let key = "restaurants"
    
    private let userDefaults = UserDefaults.standard
    
    // 모든 레스토랑 저장
    func saveRestaurants(_ restaurants: [Restaurant]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(restaurants)
            userDefaults.set(data, forKey: key)
        } catch {
            print("Error encoding restaurants: \(error)")
        }
    }
    
    // 단일 레스토랑 추가
    func addRestaurant(_ restaurant: Restaurant) -> Bool {
        var restaurants = getRestaurants()
        
        // 이름과 주소로 중복 체크
        let isDuplicate = restaurants.contains { existingRestaurant in
            return existingRestaurant.name == restaurant.name &&
            existingRestaurant.address == restaurant.address
        }
        
        if isDuplicate {
            print("Restaurant already exists!")
            return false
        }
        
        restaurants.append(restaurant)
        saveRestaurants(restaurants)
        return true
    }
    
    // 모든 레스토랑 불러오기
    func getRestaurants() -> [Restaurant] {
        guard let data = userDefaults.data(forKey: key) else { return [] }
        
        do {
            let decoder = JSONDecoder()
            let restaurants = try decoder.decode([Restaurant].self, from: data)
            return restaurants
        } catch {
            print("Error decoding restaurants: \(error)")
            return []
        }
    }
    
    // 특정 레스토랑 삭제
    func deleteRestaurant(withName name: String) {
        var restaurants = getRestaurants()
        restaurants.removeAll { $0.name == name }
        saveRestaurants(restaurants)
    }
    
    // 레스토랑 업데이트
    func updateRestaurant(_ restaurant: Restaurant) {
        var restaurants = getRestaurants()
        if let index = restaurants.firstIndex(where: { $0.name == restaurant.name }) {
            restaurants[index] = restaurant
            saveRestaurants(restaurants)
        }
    }
    
    // 모든 데이터 삭제
    func clearAllRestaurants() {
        userDefaults.removeObject(forKey: key)
    }
    
    // 레스토랑 검색
    func searchRestaurants(name: String) -> [Restaurant] {
        let restaurants = getRestaurants()
        return restaurants.filter { $0.name.localizedCaseInsensitiveContains(name) }
    }
}
