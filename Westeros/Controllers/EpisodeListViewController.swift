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
    let model: [Episode]
    
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
        
        navigationController?.pushViewController(episodeDetailViewController, animated: true)
    }
}
