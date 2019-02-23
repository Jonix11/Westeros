//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Jon Gonzalez on 22/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var seasonImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: Properties
    var model: Season
    
    // MARK: Initialization
    init(model: Season) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = model.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        syncModelWithView()
        setupUI()

        // Do any additional setup after loading the view.
    }
}

// MARK: Sync
extension SeasonDetailViewController {
    func syncModelWithView() {
        seasonNameLabel.text = model.name
        seasonImageView.image = model.image
        dateLabel.text = "Release date: \(convertToString(date: model.releaseDate))"
        title = model.name
    }
    
    func convertToString(date: Date) -> String {
        let format = DateFormatter()
        format.locale = Locale(identifier: "en_US")
        format.dateStyle = .medium
        return format.string(from: date)
    }
}

// MARK: UI
extension SeasonDetailViewController {
    func setupUI() {
        let episodeButton = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        navigationItem.rightBarButtonItem = episodeButton
    }
    
    
    @objc func displayEpisodes() {
        let episodeListViewController = EpisodeListViewController(model: model.episodesSorted)
        
        navigationController?.pushViewController(episodeListViewController, animated: true)
    }
}

extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason season: Season) {
        self.model = season
        syncModelWithView()
    }
    
    
}
