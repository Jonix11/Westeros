//
//  WikiViewController.swift
//  Westeros
//
//  Created by Jon Gonzalez on 07/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    // MARK: Properties
    var model: House
    
    // MARK: Initialization
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        syncModelWithView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Nos damos de alta en las notificaciones
        // Tan pronto como te des de alta, implementa el código para darte de baja, si no, te olvidarás
        let notificationCenter = NotificationCenter.default
        let name = Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME)
        notificationCenter.addObserver(self,
                                       selector: #selector(houseDidChange(notification:)),
                                       name: name,
                                       object: nil) //Object es quien manda la notificación
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Nos damos de baja de las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self) // Nos damos de baja de todas las notificaciones
    }
    
    func syncModelWithView() {
        // Mostramos el loadingView
        loadingView.isHidden = false
        // Lo animamos
        loadingView.startAnimating()
        title = model.name
        let request = URLRequest(url: model.wikiURL)
        webView.load(request)
    }
    
    // MARK: Notification
    @objc func houseDidChange(notification: Notification) {
        // Sacar el userInfo de la notificación, y la case del userInfo
        guard let info = notification.userInfo,
        let house = info[HOUSE_KEY] as? House else {
            return
        }
        
        // Actualizar mi modelo
        model = house
        
        // Sincronizar modelo y vista
        let backNavButton = UIBarButtonItem(title: house.name, style: .plain, target: self, action: Selector(("none")))
        navigationController?.navigationBar.topItem?.backBarButtonItem = backNavButton
        syncModelWithView()
    }

}

// Delegados
//Should: para pedir permiso
//Will: Oye, que sepas que estoy a punto de hacer algo
//Did: Hey! Que sepas que ya he terminado

extension WikiViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Detener la animación del activity indicator
        loadingView.stopAnimating()
        // Ocultarlo
        loadingView.isHidden = true
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let type = navigationAction.navigationType
        switch type {
        case .linkActivated, .formSubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
}
