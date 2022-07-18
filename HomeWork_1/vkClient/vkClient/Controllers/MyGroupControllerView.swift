//
//  MyGroupControllerView.swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 07.06.2022.
//

import UIKit

class MyGroupControllerView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let customTableViewCell = "customTableViewCell"
var arrayGroup = [Group]()


override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customTableViewCell)
    tableView.dataSource = self
    tableView.delegate = self
    NotificationCenter.default.addObserver(self, selector: #selector(didPressToGroup(_:)), name: Notification.Name("pressToGroup"), object: nil)
}
    @objc func didPressToGroup(_ notification: Notification) {
        guard let group = notification.object as? Group else { return }
        if !arrayGroup.contains(where: { groupItem in groupItem.name == group.name }) {
            arrayGroup.append(group)
            tableView.reloadData()
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension MyGroupControllerView: UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayGroup.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: customTableViewCell, for: indexPath) as! CustomTableViewCell
    cell.configure(self.arrayGroup[indexPath.row])
    return cell
}
}

extension MyGroupControllerView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
