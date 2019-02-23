//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Jon Gonzalez on 07/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var model: [Person]
    
    // MARK: Initialization
    init(model: [Person]){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Members"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Error tipiquísimo
        // Te va a seguir ocurriendo tengas 10 días de experiencia o 10 años
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = NotificationCenter.default
        let name = Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME)
        notificationCenter.addObserver(self, selector: #selector(houseDidChange(notification:)), name: name, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }

}

extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Descubrir la persona
        let person = model[indexPath.row]
        
        // Pedir una celda a la tabla si es que la tiene, o si no crearla
        let cellId = "MemberCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        // Sincronizar modelo y vista
        cell?.textLabel?.text = person.fullName
        cell?.detailTextLabel?.text = person.alias
        
        // Devolver la celda
        return cell!
    }
}

extension MemberListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let member = model[indexPath.row]
        let memberDetailViewController = MemberDetailViewController(model: member)
        
        memberDetailViewController.delegate = self
        
        navigationController?.pushViewController(memberDetailViewController, animated: true)
    }
}

extension MemberListViewController {
    @objc func houseDidChange(notification: Notification) {
        guard let info = notification.userInfo else {
            return
        }
        guard let house = info[HOUSE_KEY] as? House else {
            return
        }
        model = house.sortedMembers
        
        let backNavButton = UIBarButtonItem(title: house.name, style: .plain, target: self, action: Selector(("none")))
        navigationController?.navigationBar.topItem?.backBarButtonItem = backNavButton
        tableView.reloadData()
    }
}

extension MemberListViewController: MemberDetailViewControllerDelegate {
    func memberDetailViewController(_ viewController: MemberDetailViewController, didSelectHouse house: House) {
        model = house.sortedMembers
        tableView.reloadData()
    }
    
    
}
