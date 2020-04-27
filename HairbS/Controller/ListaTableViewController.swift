//
//  ListaTableViewController.swift
//  HairbS
//
//  Created by Paulo Uchôa on 26/04/20.
//  Copyright © 2020 HairbS-Team. All rights reserved.
//

import UIKit

class ListaTableViewController: UITableViewController {
    
    let data = LoaderJson().itemData
    
    @IBOutlet var lista: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Lista"
        lista.delegate = self
        lista.dataSource = self
        
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return data.count
    }
       
//Função que cria a Célula da table View e indica o que será apresentado na mesma.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) // Comando para reutilizar a célula criada.
       
       if cell.detailTextLabel == nil {
           cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
       
       cell.textLabel?.text = data[indexPath.row].nome //Indica qual nome do array será printado
       cell.textLabel?.textColor = UIColor(red: 0.308, green: 0.14, blue: 0.356, alpha: 100) //Muda a cor dos Títulos
       cell.detailTextLabel?.text = data[indexPath.row].nomeCientifico // Indica qual nome Científico do array será printado
       let indicator = UIImage(named: "Indicator.pdf")  // Importa uma imagem personalizada do diclosureIndicator, pois o mesmo não pode ser editado
       cell.accessoryType = .disclosureIndicator
       cell.accessoryView = UIImageView(image: indicator!)
       

       return cell
    }


}
