//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Jon Gonzalez on 07/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit


// Definir nuestro propio delegado, se definen siempre como protocolos
protocol HouseListViewControllerDelegate: class { // Este protocolo lo puede implementar cualquiera, siempre que sea una clase
    // Should
    // Will
    // Did
    func houseListViewController(_ viewController: HouseListViewController, didSelectHouse: House)
}

class HouseListViewController: UITableViewController {
    
    // MARK: Properties
    let model: [House]
    weak var delegate: HouseListViewControllerDelegate?  // se inicializa a nil hasta que le asignemos un valor, para no tener que inicializarlo en el init
    
    // MARK: Initialization
    init(model: [House]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Houses"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Descubrir cuál es la casa que tenemos que mostrar
        let house = model[indexPath.row]
        
        // Crear una celda
        let cellId = "houseCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sync celda - house (view - model)
        cell?.textLabel?.text = house.name
        cell?.imageView?.image = house.sigil.image
        
        // Devolver la celda
        return cell!
    }
    
    //MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar la casa que se ha pulsado
        let house = model[indexPath.row]
        
        
        // Avisamos al delegado
        // Quien quiera, que se conforme al HouseListViewController para hacer lo que tenga que hacer
        delegate?.houseListViewController(self, didSelectHouse: house)
        
        // Emitir la misma info por notificaciones
        let notificationCenter = NotificationCenter.default
        // Creamos la notificación
        let notification = Notification(name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [HOUSE_KEY: house])
        // Enviamos la notificación
        notificationCenter.post(notification)
        
        // Guardar la casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
    }
}

extension HouseListViewController {
    func saveLastSelectedHouse(at index: Int) {
        // UserDefault será nuestro motor de persistencia
        // UserDefaults - Write
        let userDefaults = UserDefaults.standard
        
        // Escribimos el index en una key de nuestro motor de persistencia
        userDefaults.set(index, forKey: LAST_HOUSE_KEY)
        
        // Guardamos
        userDefaults.synchronize() // Por si acaso (save)
    }
    
    func lastSelectedHouse() -> House {
        // UserDefaults - Read
        let userDefaults = UserDefaults.standard
        
        // Leemos de nuestro motor de persistencia
        let index = userDefaults.integer(forKey: LAST_HOUSE_KEY) // 0 es default
        
        // Devolvemos la casa situada en el index
        return house(at: index)
    }
    
    func house(at index: Int) -> House {
        return model[index]
    }
}
