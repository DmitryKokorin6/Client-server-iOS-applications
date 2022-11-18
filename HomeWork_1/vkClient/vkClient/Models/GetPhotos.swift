//
//  GetPhotos.swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 18.11.2022.
//

import Foundation

struct GetPhotosResponse: Decodable {
    var response: GetPhotoCountItems
}

struct GetPhotoCountItems: Decodable {
    var count: Int
    var items: [GetPhotoItems]
}

struct GetPhotoItems: Decodable {
    enum CodingKeys: CodingKey {
        case date
        case sizes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dataSince = try container.decode(Int.self, forKey: .date)
        date = Date(timeIntervalSince1970: TimeInterval(dataSince))
        sizes = try container.decode([SizesLoad].self, forKey: .sizes)
    }
    
    var date: Date
    var sizes: [SizesLoad]
}

struct SizesLoad: Decodable {
    var url: String
}
