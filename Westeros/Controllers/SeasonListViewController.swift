//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Jon Gonzalez on 21/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit

protocol SeasonListViewControllerDelegate: class {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason: Season)
}

class SeasonListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var seasonTableView: UITableView!
    
    // MARK: Properties
    let model: [Season]
    weak var delegate: SeasonListViewControllerDelegate?
    
    // MARK: Initialization
    init(model: [Season]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Seasons"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add tableView datasource and delegate
        seasonTableView.dataSource = self
        seasonTableView.delegate = self
        
        seasonTableView.tableFooterView = UIView()
        

        // Do any additional setup after loading the view.
    }
}

extension SeasonListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Discover de season
        let season = model[indexPath.row]
        
        // ask cell to de tableView or create one
        let cellId = "seasonCell"
        var cell = seasonTableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // sync model and view
        cell?.textLabel?.text = season.name
        
        // return the cell
        return cell!
    }
}

extension SeasonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let season = model[indexPath.row]
        
        delegate?.seasonListViewController(self, didSelectSeason: season)
        
        // Create the notification center
        let notificationCenter = NotificationCenter.default
        // Create the notification
        let notification = Notification(name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [SEASON_KEY: season])
        // send the notification
        notificationCenter.post(notification)
        
        
        saveLastSeasonSelected(withIndex: indexPath.row)
    }
}

extension SeasonListViewController {
    func saveLastSeasonSelected(withIndex index: Int) {
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(index, forKey: LAST_SEASON_KEY)
        
        userDefaults.synchronize()
    }
    
    func lastSeasonSelected() -> Season {
        let userDefaults = UserDefaults.standard
        let index = userDefaults.integer(forKey: LAST_SEASON_KEY)
        
        return model[index]
    }
}
