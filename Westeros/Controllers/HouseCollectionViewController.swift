//
//  HouseCollectionViewController.swift
//  Westeros
//
//  Created by Jon Gonzalez on 12/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit

class HouseCollectionViewController: UIViewController {

    enum Constants {
        static let columnCount: CGFloat = 3
        static let itemSpacing: CGFloat = 10
        static let itemHeight: CGFloat = 60
    }
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            // Instanciamos el xib
            let nib = UINib(nibName: CollectionViewCell.nibName, bundle: nil)
            
            // Registramos la celda personalizada
            collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.defaultReuseableId)
        }
    }
    
    // MARK: Properties
    let model: [House]
    private let collectionViewLayout: UICollectionViewFlowLayout
    
    // MARK: Initialization
    init(model: [House], collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) {
        self.model = model
        self.collectionViewLayout = collectionViewLayout
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        setUpUI()
    }
    
    func setUpUI() {
        let width = calculateWidth()
        collectionViewLayout.itemSize = CGSize(width: width, height: width)
        collectionView.collectionViewLayout = collectionViewLayout
        
    }
    
    func calculateWidth() -> CGFloat {
        let totalSpacing: CGFloat = (Constants.columnCount - 1) * Constants.itemSpacing
        let totalWidth: CGFloat = view.frame.width
        
        return (totalWidth - totalSpacing) / Constants.columnCount
    }
}

extension HouseCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Averiguamos la casa
        let house = model[indexPath.item]
        
        // Creamos la celda (o la obtenemos de cache)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.defaultReuseableId, for: indexPath) as! CollectionViewCell
        
        // Sincronizamos modelo y vista
        cell.imageView.image = house.sigil.image
        cell.nameLabel.text = house.name
        
        // Devolvemos de cell
        return cell
    }
    
    
}
