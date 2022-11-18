//
//  GetGroupSearch.swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 18.11.2022.
//

import Foundation

struct GetGroupSearchResponse: Decodable {
    var response: GetGroupSearchCountItems
}

struct GetGroupSearchCountItems: Decodable {
    var count: Int
    var items: [GetGroupSearchItems]
}

struct GetGroupSearchItems: Decodable {
    var name: String
}
