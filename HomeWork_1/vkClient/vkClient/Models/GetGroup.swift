//
//  GetGroup.swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 18.11.2022.
//

import Foundation

struct GetGroupResponse: Decodable {
    var response: GetGroupCountItems
}

struct GetGroupCountItems: Decodable {
    var count: Int
    var items: [GetGroupItems]
}
struct GetGroupItems: Decodable {
    var name: String
}
