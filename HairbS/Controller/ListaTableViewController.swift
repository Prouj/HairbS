//
//  ListaTableViewController.swift
//  HairbS
//
//  Created by Paulo Uchôa on 26/04/20.
//  Copyright © 2020 HairbS-Team. All rights reserved.
//

import UIKit

class ListaTableViewController:UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    
    @IBOutlet var lista: UITableView!
    
    @IBOutlet weak var search: UISearchBar!
    
    let data = LoaderJson().itemData //Todos os dados do Json
    var currentItem = ItemData() //Salva os dados do item que vai ser passado pra tela de descrição
    var currentData = LoaderJson().itemData //Dados dos itens que vão ser carregados na tableView (altera de acordo com a pesquisa)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Lista"
        
        lista.delegate = self
        lista.dataSource = self
        search.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentItem = currentData[indexPath.row] //seta o objeto item que vai ser passado pra descrição
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showDescription", sender: self)
    }
//Função que cria a Célula da table View e indica o que será apresentado na mesma.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) // Comando para reutilizar a célula criada.
       
       if cell.detailTextLabel == nil {
           cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        
        cell.textLabel?.text = currentData[indexPath.row].nome //Indica qual nome do array será printado
        cell.detailTextLabel?.text = currentData[indexPath.row].nomeCientifico // Indica qual nome Científico do array será printado
        
        cell.textLabel?.textColor = UIColor(red: 0.308, green: 0.14, blue: 0.356, alpha: 100) //Muda a cor dos Títulos
       
        let indicator = UIImage(named: "Indicator.pdf")  // Importa uma imagem personalizada do diclosureIndicator, pois o mesmo não pode ser editado
        cell.accessoryType = .disclosureIndicator
        cell.accessoryView = UIImageView(image: indicator!)

        return cell
    }
    
    //função pra passar os dados pra tela de descrição
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let descricao = segue.destination as! DescricaoViewController
        descricao.item = currentItem
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentData = data
            lista.reloadData()
            return
        }
        //verifica se o texto digitado na searchbar é referente ao nome de algum item no json
        currentData = data.filter({ itemData -> Bool in
            itemData.nome!.lowercased().contains(searchText.lowercased())
        })
        lista.reloadData() //atualiza a tableView
    }
}



