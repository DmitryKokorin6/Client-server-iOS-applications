//
//  FriendsInfo.swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 18.11.2022.
//

import Foundation

class FriendsGet {
    
    let jsonDecoder = JSONDecoder()
    
    func loadFriends() {

        var urlComponents = URLComponents(string: "https://api.vk.com/method/friends.get")
        urlComponents?.queryItems = [
            URLQueryItem(name: "user_id", value: Session.info.userId),
            URLQueryItem(name: "fields", value: "nickname"),
            URLQueryItem(name: "count", value: "300"),
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "access_token", value: Session.info.token),
            URLQueryItem(name: "v", value: "5.81"),
        ]
        guard let url = urlComponents?.url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in

//            print("response --> \(response)")
//            print("error --> \(error)")
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(GetFriendsResponse.self, from: data)
                print(result)
            } catch {
                print(error)
            }
//            print("Body --> \(String(data: data, encoding: .utf8))")
        }.resume()

    }
    
}
