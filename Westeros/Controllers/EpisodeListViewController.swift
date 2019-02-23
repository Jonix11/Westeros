//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Jon Gonzalez on 22/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit

class EpisodeListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var episodeTableView: UITableView!
    
    // MARK: Properties
    var model: [Episode]
    
    // MARK: Initialization
    init(model: [Episode]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Episodes"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodeTableView.dataSource = self
        episodeTableView.delegate = self
        
        episodeTableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let notificationCenter = NotificationCenter.default
        let name = Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME)
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange(notification:)), name: name, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
}

extension EpisodeListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let episode = model[indexPath.row]
        
        let cellId = "episodeCell"
        var cell = episodeTableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = episode.title
        
        return cell!
    }
}
extension EpisodeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = model[indexPath.row]
        
        let episodeDetailViewController = EpisodeDetailViewController(model: episode)
        
        episodeDetailViewController.delegate = self
        
        navigationController?.pushViewController(episodeDetailViewController, animated: true)
    }
}

extension EpisodeListViewController {
    // MARK: Notification
    @objc func seasonDidChange(notification: Notification) {
        guard let info = notification.userInfo else {
            return
        }
        guard let season = info[SEASON_KEY] as? Season else {
            return
        }
        
        model = season.episodesSorted
        let buttonTitle = season.name
        let backNavButton = UIBarButtonItem(title: buttonTitle, style: .plain, target: self, action: Selector(("none")))
        navigationController?.navigationBar.topItem?.backBarButtonItem = backNavButton
        episodeTableView.reloadData()
    }
}
extension EpisodeListViewController: EpisodeDetailViewControllerDelegate {
    func episodeDetailViewController(_ viewController: EpisodeDetailViewController, didSelectSeason season: Season) {
        model = season.episodesSorted
        episodeTableView.reloadData()
    }
    
    
}
