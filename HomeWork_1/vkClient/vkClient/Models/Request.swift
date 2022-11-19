//
//  Request.swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 18.11.2022.
//

import Foundation

class Request<T: Decodable> {
    
    let jsonDecoder = JSONDecoder()
    lazy var session = URLSession.shared
    private var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.vk.com"
        return constructor
    }()
    
    func fetch(type: RequestType) {
        var constructor = urlConstructor
        switch type {
            case .friends:
                constructor.path = "/method/friends.get"
                constructor.queryItems = [
                    URLQueryItem(name: "user_id", value: Session.info.userId),
                    URLQueryItem(name: "fields", value: "nickname"),
                    URLQueryItem(name: "count", value: "300"),
                    URLQueryItem(name: "order", value: "hints"),
                    URLQueryItem(name: "access_token", value: Session.info.token),
                    URLQueryItem(name: "v", value: "5.81")
                ]
            case .groups:
                constructor.path = "/method/groups.get"
                constructor.queryItems = [
                    URLQueryItem(name: "user_id", value: Session.info.userId),
                    URLQueryItem(name: "extended", value: "1"),
                    URLQueryItem(name: "access_token", value: Session.info.token),
                    URLQueryItem(name: "v", value: "5.81")
                ]
            case .groupsSearch:
                constructor.path = "/method/groups.search"
                constructor.queryItems = [
                    URLQueryItem(name: "q", value: "GeekBrains"),
                    URLQueryItem(name: "count", value: "1000"),
                    URLQueryItem(name: "v", value: "5.81"),
                    URLQueryItem(name: "access_token", value: Session.info.token)
                ]
            case .photo:
                constructor.path = "/method/photos.get"
                constructor.queryItems = [
                    URLQueryItem(name: "album_id", value: "profile"),
                    URLQueryItem(name: "v", value: "5.81"),
                    URLQueryItem(name: "access_token", value: Session.info.token)
                ]
        }
        guard let url = constructor.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let result = try self.jsonDecoder.decode(Response<T>.self, from: data)
                print(result)
            } catch {
                print(error)
            }
        }.resume()
    }
}


extension Request {
    enum RequestType {
        case friends
        case groups
        case groupsSearch
        case photo
    }
}
