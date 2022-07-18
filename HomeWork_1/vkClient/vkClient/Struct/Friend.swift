//
//  Friend.swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 05.06.2022.
//

struct MyPhoto {
    var index: String
    var isLiked = false
    var likeCounter = 0
    
}

struct Friend {
    var age: String
    var avatar: String

    var name: String
    var fotoAlbum = [MyPhoto]()
}
