//
//  WebLoginViewController.swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 26.07.2022.
//

import Foundation
import WebKit



class WebLoginViewController: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
          super.viewDidLoad()
          
          webView.navigationDelegate = self
//        var urlComponents = URLComponents(string: "https://api.vk.com/method/photos.get")
//            urlComponents?.queryItems = [
//                URLQueryItem(name: "album_id", value: "profile"),
//                URLQueryItem(name: "access_token", value: token),
//                URLQueryItem(name: "v", value: "5.81")
//            ]
//            guard let url = urlComponents?.url else { return }
//
//        URLSession.shared.dataTask(with: url) { [self] data, response, error in
//                print("response --> \(response)")
//                print("error --> \(error)")
//
//                guard let data = data else { return }
//                print("Body -->\(String(data: data, encoding: .utf8))")
//
//            }
//        let request = URLRequest(url: url)
//        webView.load(request)
          
          var urlComponents = URLComponents(string: "https://oauth.vk.com/authorize")


          urlComponents?.queryItems = [
              URLQueryItem(name: "client_id", value: "8222650"),
              URLQueryItem(name: "display", value: "mobile"),
              URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
              URLQueryItem(name: "scope", value: "336918"),
              URLQueryItem(name: "response_type", value: "token"),
              URLQueryItem(name: "v", value: "5.68")
          ]
          guard let url = urlComponents?.url else {
              return
          }
          print(url)
          let request = URLRequest(url: url)
          webView.load(request)
        
      }

  }
      //vk1.a.B5qkJTEX02iJ9yGqfg9HTg3gkP7STTN1MQnBTjyO_L_mrwzGzcPqopHbvSBBNMSu8KumRTfG7NJH-BYmQnYe9aFi5odDIXwWD6S-zk7NTNoUdb_JO4OEcSwIWcUBMSao00Sv6euto_vK_sM9Zak_A0nuRq3A1wPvwl1VvgKQXMe5YAcyNel55eJnWxzptrU6

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
              
              print("response --> \(response)")
              print("error --> \(error)")
              guard let data = data else { return }
              
              print("Body --> \(String(data: data, encoding: .utf8))")
          }.resume()
          
          
              // 7. Получение фотографий человека;
          
          var urlComponentsPhotoGet = URLComponents(string: "https://api.vk.com/method/photos.get")
              urlComponentsPhotoGet?.queryItems = [
                  URLQueryItem(name: "album_id", value: "profile"),
                  URLQueryItem(name: "v", value: "5.81"),
                  URLQueryItem(name: "access_token", value: Session.info.token)
              ]
              guard let url = urlComponentsPhotoGet?.url else { return }
              
              URLSession.shared.dataTask(with: url) { data, response, error in
                  print("response --> \(response)")
                  print("error --> \(error)")
                  
                  guard let data = data else { return }
                  print("Body -->\(String(data: data, encoding: .utf8))")
              }.resume()
          
          // 8. Получение групп текущего пользователя
          
          var urlComponentsGroupsGet = URLComponents(string: "https://api.vk.com/method/groups.get")
          urlComponentsGroupsGet?.queryItems = [
            URLQueryItem(name: "user_id", value: Session.info.userId),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "access_token", value: Session.info.token),
            URLQueryItem(name: "v", value: "5.81")
          ]
          
          guard let url = urlComponentsGroupsGet?.url else { return }
          
          URLSession.shared.dataTask(with: url) { data, response, error in
              
              print("Error --> \(error)")
              print("Response --> \(response)")
              
              guard let data = data else { return }
              
              print("Body --> \(String(data: data, encoding: .utf8))")
          }.resume()
          
          
          
          
          
          // 9. Получение групп по поисковому запросу
          
          var urlComponentsGroupsSearch = URLComponents(string: "https://api.vk.com/method/groups.search")
          
          urlComponentsGroupsSearch?.queryItems = [
            URLQueryItem(name: "q", value: "GeekBrains"),
            URLQueryItem(name: "count", value: "1000"),
            URLQueryItem(name: "v", value: "5.81"),
            URLQueryItem(name: "access_token", value: Session.info.token)
          ]
          guard let url = urlComponentsGroupsSearch?.url else { return }
          
          URLSession.shared.dataTask(with: url) { data, response, error in
              print("Error --> \(error)")
              print("Response --> \(response)")
              
              guard let data = data else { return }
              
              print("Body --> \(String(data: data, encoding: .utf8))")
          }.resume()
          
          decisionHandler(.cancel)
      }
      


}
