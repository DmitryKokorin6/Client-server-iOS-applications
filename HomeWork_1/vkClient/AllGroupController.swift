//
//  AllGroupController.swift
//  vkClient
//
//  Created by Rodion Molchanov on 31.05.2022.
//

import UIKit

class AllGroupController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    func fillDate() -> [Group] {
        let group1 = Group(avatar: "IMG_90C0B1091B97-1", name: "клуб отдыха", desc: "Отдых")
        let group2 = Group(avatar: "IMG_60249539DDAC-1", name: "клуб красоты", desc: "Красота")
        let group3 = Group(avatar: "IMG_D60F1A5EF7F6-1", name: "клуб любителей учиться", desc: "Экзамены")
        
        var arrayGroup = [Group]()
        arrayGroup.append(group1)
        arrayGroup.append(group2)
        arrayGroup.append(group3)
        return arrayGroup
    }
    
    let customTableViewCell = "customTableViewCell"
    var arrayGroup = [Group]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayGroup = fillDate()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customTableViewCell)
        tableView.dataSource = self
        tableView.delegate = self

    }
    }
    
extension AllGroupController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayGroup.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: customTableViewCell, for: indexPath) as! CustomTableViewCell
        cell.configure(self.arrayGroup[indexPath.row])
        return cell
    }
}

extension AllGroupController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = arrayGroup[indexPath.item]
        NotificationCenter.default.post(name: Notification.Name("pressToGroup"), object: group)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 200
    }
}
