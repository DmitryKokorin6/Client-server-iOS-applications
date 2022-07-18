//
//  Storage.swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 07.07.2022.
//

import UIKit

class Storage: NSObject {
    static let shared = Storage()
    private override init() {
    super.init()
    }
    
    
    var friends = [Friend]()
}
