//
//  CollectionTableViewCell.swift
//  Inicial
//
//  Created by Larissa Uchoa on 28/04/20.
//  Copyright © 2020 Larissa Uchoa. All rights reserved.
//

import UIKit


protocol CellDelegate {
    func didTapButton(in cell: CollectionTableViewCell)
    func didSelectItem(in collection: MyCell)
}

class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    static let identifier = "CollectionTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionTableViewCell", bundle: nil)
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var headerTitle: UILabel!
    
    @IBOutlet var headerButton: UIButton!

    var cellIdentifier: String!
    
    var data: [ItemData] = []
    
    var delegate: CellDelegate?
    
    //Defini o título da seção da table
    func titulo(title: String) {
        self.headerTitle.text = title
    }
    
    //Faz o carregamento da collectionView a partir do array data
    func configure(with data: [ItemData], delegate: CellDelegate) {
        self.data = data
        self.delegate = delegate
        collectionView.reloadData()
    }
    
    //Registra o tipo de célula da collectionView
    func register<T: MyCell>(_ cellType: T.Type) {
        cellIdentifier = cellType.identifier
        
        //Oculta o botão na seção de Populares
        if cellIdentifier == "My2CollectionViewCell" {
            headerButton.isHidden = true
        }
        collectionView.register(cellType.nib(), forCellWithReuseIdentifier: cellType.identifier)
    }
    //Carrega o nib das células da collection
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        headerButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    @objc func tap() {
        delegate?.didTapButton(in: self)
    }
    
    // COLLECTION VIEW
    
    //Define o número de itens por seção
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    //Cria a célular da tableView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Defini a célula como reutilizável
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
        
        //Indica o dado de acordo com a linha
        cell.configure(with: data[indexPath.row])
       
        return cell
    }
    
    //Defini configuração de Layout da célula
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Altera o tamanho da célula dependando do tipo
        if cellIdentifier == MyCollectionViewCell.identifier {
            return CGSize(width: 85, height: 100)
        } else {
            return CGSize(width: 275, height: 150)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        delegate?.didSelectItem(in: cell as! MyCell)
    }
    
    func getHeaderTitle() -> String?{
        return self.headerTitle.text
    }
    
    
}

