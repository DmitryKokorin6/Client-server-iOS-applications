//
//  WebLoginViewController.swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 26.07.2022.
//

import Foundation
import WebKit



class WebLoginViewController: UIViewController {
    
    private let friendsRequest = Request<FriendsItems>()
    private let groupsRequest = Request<GetGroupItems>()
    private let groupSearchRequest = Request<GetGroupSearchItems>()
    private let photoRequest = Request<GetPhotoItems>()
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
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
        friendsRequest.fetch(type: Request.RequestType.friends)
        groupsRequest.fetch(type: Request.RequestType.groups)
        groupSearchRequest.fetch(type: Request.RequestType.groupsSearch)
        photoRequest.fetch(type: Request.RequestType.photo)
    }
    
}
