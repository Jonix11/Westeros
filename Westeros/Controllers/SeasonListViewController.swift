//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Jon Gonzalez on 21/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit

class SeasonListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var seasonTableView: UITableView!
    
    // MARK: Properties
    let model: [Season]
    
    // MARK: Initialization
    init(model: [Season]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Game of Thrones Seasons"
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
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
}
