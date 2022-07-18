//
//  MyFriendsController.swift
//  vkClient
//
//  Created by Rodion Molchanov on 31.05.2022.
//

import UIKit

class MyFriendsController: UIViewController {

    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let fromFriendListToGallery = "fromFriendListToGallery"
    var myFriends = [Friend]()

    
    let customCellReuseIdentifier = "customCellReuseIdentifier"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myFriends = Storage.shared.friends
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customCellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
       
    }

extension MyFriendsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            myFriends = Storage.shared.friends
        }else {
            myFriends = Storage.shared.friends.filter({ friendItem in
                friendItem.name.lowercased().contains(searchText.lowercased())
            })
        }
        
        tableView.reloadData()
    }
}

extension MyFriendsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFriends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customCellReuseIdentifier, for: indexPath) as? CustomTableViewCell
        else {
            return UITableViewCell()
        }
        
        let friend = myFriends[indexPath.row]
        cell.configure(image: UIImage(named: friend.avatar), name: friend.name, description: friend.age, closure: { [weak self] in
            guard let self = self else { return }
            self.performSegue(withIdentifier: self.fromFriendListToGallery, sender: indexPath.row)
        })
        return cell
    }
    
    
}

extension MyFriendsController: UITableViewDelegate {
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == fromFriendListToGallery,
           let descueController = segue.destination as? GalleryViewController,
           let fotoArrayIndex = sender as? Int {
            
            descueController.fotoAlbumIndex = fotoArrayIndex
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         performSegue(withIdentifier: fromFriendListToGallery, sender: indexPath.row)
    }
    
}

