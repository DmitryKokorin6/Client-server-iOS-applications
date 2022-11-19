//
//  Extencion .swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 18.11.2022.
//

import Foundation
import WebKit

extension WebLoginViewController: WKNavigationDelegate {

    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        //decisionHandler(.allow)
        
        guard
            let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String : String](), { partialResult, param in
                var dict = partialResult
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            })
        
        let token = params["access_token"]
        
        print(token)
        print(params["user_id"])
        

        
        // 6. Получение списка друзей
        
//        func getFriends() {
//            var urlComponents = URLComponents(string: "https://api.vk.com/method/friends.get")
//            urlComponents?.queryItems = [
//                URLQueryItem(name: "user_id", value: Session.info.userId),
//                URLQueryItem(name: "fields", value: "nickname"),
//                URLQueryItem(name: "count", value: "300"),
//                URLQueryItem(name: "order", value: "hints"),
//                URLQueryItem(name: "access_token", value: Session.info.token),
//                URLQueryItem(name: "v", value: "5.81"),
//            ]
//            guard let url = urlComponents?.url else { return }
//
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                guard let data = data else { return }
//                do {
//                    let result = try self.jsonDecoder.decode(GetFriendsResponse.self, from: data)
//                    print(result)
//                } catch {
//                    print(error)
//                }
//            }.resume()
//        }
        
            // 7. Получение фотографий человека;
        
//        func getPhoto() {
//            var urlComponentsPhotoGet = URLComponents(string: "https://api.vk.com/method/photos.get")
//            urlComponentsPhotoGet?.queryItems = [
//                URLQueryItem(name: "album_id", value: "profile"),
//                URLQueryItem(name: "v", value: "5.81"),
//                URLQueryItem(name: "access_token", value: Session.info.token)
//            ]
//            guard let url = urlComponentsPhotoGet?.url else { return }
//
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                guard let data = data else { return }
//                do {
//                    let result = try self.jsonDecoder.decode(GetPhotosResponse.self, from: data)
//                    print(result)
//                } catch {
//                    print(error)
//                }
//            }.resume()
//        }
        // 8. Получение групп текущего пользователя
        
//        func getGroups() {
//            var urlComponentsGroupsGet = URLComponents(string: "https://api.vk.com/method/groups.get")
//            urlComponentsGroupsGet?.queryItems = [
//                URLQueryItem(name: "user_id", value: Session.info.userId),
//                URLQueryItem(name: "extended", value: "1"),
//                URLQueryItem(name: "access_token", value: Session.info.token),
//                URLQueryItem(name: "v", value: "5.81")
//            ]
//            guard let url = urlComponentsGroupsGet?.url else { return }
//
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                guard let data = data else { return }
//
//                do {
//                    let result = try self.jsonDecoder.decode(GetGroupResponse.self, from: data)
//                    print(result)
//                } catch {
//                    print(error)
//                }
//            }.resume()
//        }
        // 9. Получение групп по поисковому запросу
        
//        func getGroupsSearch() {
//            var urlComponentsGroupsSearch = URLComponents(string: "https://api.vk.com/method/groups.search")
//
//            urlComponentsGroupsSearch?.queryItems = [
//                URLQueryItem(name: "q", value: "GeekBrains"),
//                URLQueryItem(name: "count", value: "1000"),
//                URLQueryItem(name: "v", value: "5.81"),
//                URLQueryItem(name: "access_token", value: Session.info.token)
//            ]
//            guard let url = urlComponentsGroupsSearch?.url else { return }
//
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                guard let data = data else { return }
//                do {
//                    let result = try self.jsonDecoder.decode(GetGroupSearchResponse.self, from: data)
//                    print(result)
//                } catch {
//                    print(error)
//                }
//            }.resume()
//        }
        decisionHandler(.cancel)
    }
}
