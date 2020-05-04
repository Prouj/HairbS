//
//  DescricaoViewController.swift
//  HairbS
//
//  Created by Nathália Cardoso on 28/04/20.
//  Copyright © 2020 HairbS-Team. All rights reserved.
//

import UIKit

class DescricaoViewController: UIViewController {
    
    @IBOutlet weak var descricaoCardView: DescricaoCard!
    
    
    var item = ItemData() //variavel que recebe as informações do item selecionado na tableView
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let image = UIImage(named: "AppIcon") //vai mudar quando tiver o banco das imagens
        descricaoCardView.imageView.image = image
        descricaoCardView.imageView.layer.cornerRadius = 48 //porque o tamanha padrão da imagem é 96x96
        
        //seta os valores dos objetos de acordo com o json
        
        guard let nome = item.nome, let descricao = item.text else {
            return
        }
        descricaoCardView.nomeLabel.text = nome
        descricaoCardView.descricaoTextView.text = descricao
        title = nome
        
        guard let nomeCientifico = item.nomeCientifico else {
            descricaoCardView.nomeCientificoLabel.isHidden = true
            return
        }
        descricaoCardView.nomeCientificoLabel.text = nomeCientifico
        // Do any additional setup after loading the view.
    }
    //envia informações pra tela de detalhes
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detalhes = segue.destination as! DetalhesViewController
        detalhes.detalhes = item.pele!
    }

}
