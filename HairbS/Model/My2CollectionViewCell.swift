//
//  My2CollectionViewCell.swift
//  Inicial
//
//  Created by Paulo Uchôa on 30/04/20.
//  Copyright © 2020 Larissa Uchoa. All rights reserved.
//

import UIKit

class My2CollectionViewCell: UICollectionViewCell, MyCell {
    

    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var myTitle: UILabel!
    
    @IBOutlet weak var minText: UILabel!
    
    static let identifier = "My2CollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "My2CollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    //Define o que será apresentado na célula.
    public func configure(with data: ItemData){
        self.myImage.image = UIImage(named: data.nomeImagemPopular ?? "Erro")
        self.myTitle.text = data.nome
        self.minText.text = data.minText
    }
    
    public func getName() -> String {
        return myTitle.text!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
    }
    
}
