//
//  ViewController.swift
//  Inicial
//
//  Created by Larissa Uchoa on 28/04/20.
//  Copyright © 2020 Larissa Uchoa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!

    
    var data = LoaderJson().itemData

    let indexFav = IndexPath.init(row: 1, section: 0)
    
    //Filtra os dados que serão apresentados em cada linha da tableView
    func filtro(data: [ItemData], filtro: String) -> [ItemData] {
        var 👀: [ItemData] = []
        if filtro == "popular" {
            👀 = data.filter({$0.popular==true})
        } else if filtro == "favoritos" {
            👀 = data.filter({$0.favorito==true})
        } else if filtro == "plantas" {
            👀 = data.filter({$0.tipo=="planta"})
        } else if filtro == "argila" {
            👀 = data.filter({$0.tipo=="argila"})
        }
        return 👀
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
    }
    
    // Recarrega o json e a tableviw
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        data = LoaderJson().itemData
        
        // Trocado o metodo de reload para que ao abrir o app a table seja carregada uma única vez, e posteriormente só será atualizado a table de favoritos.
        //table.reloadData()
        table.reloadRows(at: [indexFav], with: .fade)
    }
    
    // TABLE FUNCTIONS
    
    
    //Retorna o número de linhas por seção da tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    //Cria as células da tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        //Torna as células da tableView reutilizáveis
        let cell = table.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        
        //Indica qual será o conteúdo de acordo com a linha da tableView
        switch indexPath.row {
        case 0:
            cell.titulo(title: "Sugestões")
            cell.register(My2CollectionViewCell.self)
            cell.configure(with: filtro(data: self.data, filtro: "popular"), delegate: self)
        case 1:
            
            cell.titulo(title: "Favoritos")
            cell.register(MyCollectionViewCell.self)
            cell.configure(with: filtro(data: self.data, filtro: "favoritos"), delegate: self)
            if filtro(data: self.data, filtro: "favoritos").isEmpty {
                cell.emptyStateFavorito()
            } else {
                cell.removeEmptyStateFavorito()
            }
            
        case 2:
            cell.titulo(title: "Plantas")
            cell.register(MyCollectionViewCell.self)
            // Adicionado um shuffle nas plantas
            cell.configure(with: filtro(data: self.data, filtro: "plantas").shuffled(), delegate: self)
        case 3:
            cell.titulo(title: "Argilas")
            cell.register(MyCollectionViewCell.self)
            // Adicionado um shuffle nas argilas
            cell.configure(with: filtro(data: self.data, filtro: "argila").shuffled(), delegate: self)
            cell.removeEmptyStateFavorito()
        default:
            cell.titulo(title: "😵")
        }
        
        
        //Desativa a animação de toque da tableView
        cell.selectionStyle = .none
        
        return cell
    }
    
    //Altera o tamanho da célula da tableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 240
        } else {
            return 190
        }
    }
    
}


extension ViewController: CellDelegate {
    // verifica se clicou no botão ver mais e direciona para tela de Lista
    func didTapButton(in cell: CollectionTableViewCell) {
        //print(#function)
        //print(table.indexPath(for: cell)!)
        let storyboard = UIStoryboard(name: "Lista", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "listaViewController") as! ListaTableViewController
        // configurar coisas da ListaTableViewContorller injetando os dados
        viewController.section = verificaIdNumero(nomeDoId: cell.getHeaderTitle())
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // verifica se clicou em uma célula da collection e direciona para tela de descrição
    func didSelectItem(in collection: MyCell) {
        let storyboard = UIStoryboard(name: "Descricao", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DescricaoViewController") as! DescricaoViewController
        
        // configurar coisas da DescricaoViewController injetando os dados
        let name = collection.getName()
        for i in 0...data.count {
            if data[i].nome == name {
                viewController.item = data[i]
                break
            }
        }
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    //verificar id numero de acordo com o nome do id da celula
    func verificaIdNumero(nomeDoId: String?) -> Int{
        switch nomeDoId {
        case "Favoritos":
            return 1
        case "Plantas":
            return 2
        case "Argilas":
            return 3
        default:
            return 0
        }
    }
    
}



