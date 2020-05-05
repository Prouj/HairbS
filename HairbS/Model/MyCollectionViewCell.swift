//
//  MyCollectionViewCell.swift
//  Inicial
//
//  Created by Larissa Uchoa on 28/04/20.
//  Copyright © 2020 Larissa Uchoa. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell, MyCell {

    @IBOutlet var myImage: UIImageView!
    
    @IBOutlet weak var myLabel: UILabel!
    
    static let identifier = "MyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //Define o que será apresentado na célula.
    public func configure(with data: ItemData){
        self.myImage.image = UIImage(named: data.nomeImagem ?? "Erro")
        self.myLabel.text = data.nome
    }
    
    public func getName() -> String {
        return myLabel.text!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
    }
    
}
