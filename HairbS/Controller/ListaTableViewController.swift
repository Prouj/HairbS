//
//  ListaTableViewController.swift
//  HairbS
//
//  Created by Paulo Uchôa on 26/04/20.
//  Copyright © 2020 HairbS-Team. All rights reserved.
//

import UIKit

class ListaTableViewController:UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    let data = LoaderJson().itemData
    var titleNav = ""
    var currentData = LoaderJson().itemData
    var isSearching = false
    
    @IBOutlet var lista: UITableView!
    
    @IBOutlet weak var search: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Lista"
        lista.delegate = self
        lista.dataSource = self
        setUpSearchBar()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.titleNav = currentData[indexPath.row].nome!
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showDescription", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
    private func setUpSearchBar(){
        search.delegate = self
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let descricao = segue.destination as! DescricaoViewController
        descricao.titleNav = self.titleNav
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentData = data
            lista.reloadData()
            return
        }
        currentData = data.filter({ itemData -> Bool in
            itemData.nome!.lowercased().contains(searchText.lowercased())
        })
        lista.reloadData()
    }
}



