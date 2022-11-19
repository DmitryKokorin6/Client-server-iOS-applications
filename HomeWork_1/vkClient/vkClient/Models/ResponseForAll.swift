//
//  RequestForAll.swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 18.11.2022.
//

import Foundation

struct Response<ItemsType: Decodable>: Decodable {
    let response: Items<ItemsType>
}

struct Items<ItemsType: Decodable>: Decodable {
    let items: [ItemsType]
    let count: Int?
}
