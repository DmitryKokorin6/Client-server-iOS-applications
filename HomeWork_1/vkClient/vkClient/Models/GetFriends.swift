//
//  GetFriends.swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 18.11.2022.
//

import Foundation

struct GetFriendsResponse: Decodable {
    var response: GetFriendsCountItems
}

struct GetFriendsCountItems: Decodable {
    var count: Int?
    var items: [FriendsItems]
}

struct FriendsItems: Decodable {
    var id: Int?
    var firstName: String?
    var lastName: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case id
    }
}
