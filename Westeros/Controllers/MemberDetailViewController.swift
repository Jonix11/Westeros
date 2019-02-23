//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Jon Gonzalez on 23/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit

protocol MemberDetailViewControllerDelegate: class {
    func memberDetailViewController(_ viewController: MemberDetailViewController, didSelectHouse: House)
}

class MemberDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var memberNameLabel: UILabel!
    @IBOutlet weak var memberAliasLabel: UILabel!
    @IBOutlet weak var memberImageView: UIImageView!
    
    // MARK: Properties
    let model: Person
    weak var delegate: MemberDetailViewControllerDelegate?
    
    // MARK: Initialization
    init(model: Person) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "\(model.name) \(model.house.name)"
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
        let name = Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME)
        notificationCenter.addObserver(self, selector: #selector(houseDidChange(notification:)), name: name, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
}

extension MemberDetailViewController {
    func syncModelWithView() {
        memberNameLabel.text = "\(model.name) \(model.house.name)"
        memberAliasLabel.text = model.alias
        memberImageView.image = model.image
    }
    
    @objc func houseDidChange(notification: Notification) {
        guard let info = notification.userInfo, let house = info[HOUSE_KEY] as? House else {
            return
        }
        
        delegate?.memberDetailViewController(self, didSelectHouse: house)
        navigationController?.popViewController(animated: true)
    }
}
