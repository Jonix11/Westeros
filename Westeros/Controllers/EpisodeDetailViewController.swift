//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Jon Gonzalez on 22/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeAirDateLabel: UILabel!
    @IBOutlet weak var episodeSummaryLabel: UILabel!
    
    // MARK: Properties
    let model: Episode
    
    // MARK: Initialization
    init(model: Episode) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
}
