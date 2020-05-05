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
    
    @IBOutlet weak var peleButton: UIButton!
    
    @IBOutlet weak var cabeloButton: UIButton!
    
    var item = ItemData() //variavel que recebe as informações do item selecionado na tableView
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //verifica se possui detalhes para pele e cabelo, caso não exista esconde os botões
        if item.cabelo == nil{
            cabeloButton.isHidden = true
        }
        if item.pele == nil{
            peleButton.isHidden = true
        }
        
        let imageName = item.nomeImagem ?? "Erro"
        let image = UIImage(named: imageName) //pega a imagem no assets
        
        descricaoCardView.imageView.image = image //seta a imagem no imageView
        descricaoCardView.imageView.layer.cornerRadius = 48 //porque o tamanha padrão da imageView é 96x96
        
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
        guard let id = segue.identifier else {return}
        
        switch id {
        case "segueDescricaoPele":
            let detalhes = segue.destination as! DetalhesViewController
            detalhes.detalhes = item.pele!
        case "segueDescricaoCabelo":
            let detalhes = segue.destination as! DetalhesViewController
            detalhes.detalhes = item.cabelo!
        default:
            break
        }
    }

}
