//
//  DescricaoCard.swift
//  HairbS
//
//  Created by Nathália Cardoso on 30/04/20.
//  Copyright © 2020 HairbS-Team. All rights reserved.
//

import UIKit

class DescricaoCard: UIView {
    
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var nomeCientificoLabel: UILabel!
    @IBOutlet weak var descricaoTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        //carrega a xib
        Bundle.main.loadNibNamed("DescricaoCard", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        //setando a sombra da view
        contentView.layer.cornerRadius = 20
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0.4)
        contentView.layer.shadowOpacity = 0.2
        
        contentView.layer.shadowRadius = 20
    }

}
