//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Jon Gonzalez on 22/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit

protocol EpisodeDetailViewControllerDelegate: class {
    func episodeDetailViewController(_ viewController: EpisodeDetailViewController, didSelectSeason: Season)
}

class EpisodeDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeAirDateLabel: UILabel!
    @IBOutlet weak var episodeSummaryLabel: UILabel!
    
    // MARK: Properties
    let model: Episode
    weak var delegate: EpisodeDetailViewControllerDelegate?
    
    // MARK: Initialization
    init(model: Episode) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        syncModelWithView()
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
    }
}

extension EpisodeDetailViewController {
    func syncModelWithView() {
        episodeTitleLabel.text = model.title
        episodeAirDateLabel.text = "Air date: \(convertToString(date: model.airDate))"
        episodeSummaryLabel.text = "Summary: \n\n\(model.summary)"
    }
    
    func convertToString(date: Date) -> String {
        let format = DateFormatter()
        format.locale = Locale(identifier: "en_US")
        format.dateStyle = .medium
        return format.string(from: date)
    }
    
    @objc func seasonDidChange(notification: Notification) {
        guard let info = notification.userInfo, let season = info[SEASON_KEY] as? Season else {
            return
        }
        delegate?.episodeDetailViewController(self, didSelectSeason: season)
        navigationController?.popViewController(animated: true)
    }
}
