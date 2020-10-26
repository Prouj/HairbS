//
//  DescricaoViewController.swift
//  HairbS
//
//  Created by Nathália Cardoso on 28/04/20.
//  Copyright © 2020 HairbS-Team. All rights reserved.
//

import UIKit

class DescricaoViewController: UIViewController {
    
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionItem: UILabel!
    @IBOutlet weak var peleButton: UIButton!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var cabeloButton: UIButton!
    
    var item = ItemData() //variavel que recebe as informações do item selecionado na tableView
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        // Cria um botão modelo e suas configurações
        let favButton = UIButton(type: .custom)
        favButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        if item.favorito == false {
            favButton.setImage(UIImage(named:"Favorito"), for: .normal)
        } else {
            favButton.setImage(UIImage(named: "Favorito-Selected"), for: .normal)
        }
        favButton.addTarget(self, action: #selector(myRightSideBarButtonItemTapped(favButton:_:)), for: UIControl.Event.touchUpInside)
        
        // Seta o botão modelo como um botão da Navigation Bar
        let favBarButton = UIBarButtonItem(customView: favButton)
        let currWidth = favBarButton.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth?.isActive = true
        let currHeight = favBarButton.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight?.isActive = true
      
        self.navigationItem.rightBarButtonItem = favBarButton
        
        //verifica se possui detalhes para pele e cabelo, caso não exista esconde os botões
        if item.cabelo == nil{
            cabeloButton.isHidden = true
        }
        if item.pele == nil{
            peleButton.isHidden = true
        }
        
        let imageName = item.nomeImagem ?? "Erro"
        let Asset = UIImage(named: imageName) //pega a imagem no assets
        
        image.image = Asset //seta a imagem no imageView
        image.layer.cornerRadius = 48 //porque o tamanha padrão da imageView é 96x96
        
        //seta os valores dos objetos de acordo com o json
        
        guard let nome = item.nome, let descricao = item.text else {
            return
        }
        titleName.text = nome
        descriptionItem.text = descricao
        title = nome
        
        guard let nomeCientifico = item.nomeCientifico else {
            subTitle.isHidden = true
            return
        }
        subTitle.text = nomeCientifico
        // Do any additional setup after loading the view.
    }
    
    @objc func myRightSideBarButtonItemTapped(favButton: UIButton,_ sender:UIBarButtonItem!) {
        item.favorito = !item.favorito!
        if item.favorito == false {
            favButton.setImage(UIImage(named:"Favorito"), for: .normal)
        } else {
            favButton.setImage(UIImage(named: "Favorito-Selected"), for: .normal)
        }

        var data = LoaderJson().itemData
        for i in 0...data.count {
            if data[i].nome == item.nome {
                data[i].favorito = item.favorito
                break
            }
        }
        
        LoaderJson().save(update: data)
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
