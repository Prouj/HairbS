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
    
    var section:Int? //recebe o id referente ao nome da seção clicada na tela inicial
    
    var data = LoaderJson().itemData //Todos os dados do Json
    var currentItem = ItemData() //Salva os dados do item que vai ser passado pra tela de descrição
    var currentData = LoaderJson().itemData //Dados dos itens que vão ser carregados na tableView (altera de acordo com a pesquisa)
    
    
    override func viewDidLoad() {
        
        title = "Lista"
        
        lista.delegate = self
        lista.dataSource = self
        search.delegate = self
        
        carregaSection()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        data = LoaderJson().itemData //reload dos dados
        
        carregaSection()
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
        if searchText.isEmpty {
            self.searchBar(searchBar, selectedScopeButtonIndexDidChange: section!)
            lista.reloadData()
        } else {
            self.searchBar(searchBar, selectedScopeButtonIndexDidChange: section!)
            currentData = currentData.filter({ itemData -> Bool in itemData.nome!.lowercased().contains(searchText.lowercased())
                    })
            
        }
        lista.reloadData() //atualiza a tableView
    }
    //função pra filtrar de acordo com o scopo selecionado
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentData = data
            lista.restore()
        case 1:
            currentData = data.filter({ itemData -> Bool in
                itemData.favorito!
            })
            if currentData.isEmpty {
                lista.setEmptyView(title: "", message: "Você ainda não possui nenhum favorito")
            } else {
                lista.restore()
            }
        case 2:
            currentData = data.filter({ itemData -> Bool in
                itemData.tipo! == "planta"
            })
            lista.restore()
        case 3:
            currentData = data.filter({ itemData -> Bool in
                itemData.tipo! == "argila"
            })
            lista.restore()
        default:
            break
        }
        section = selectedScope
        lista.reloadData()
    }
    
    //carrega o escopo e os dados que vão aparecer na table view
    func carregaSection() {
        self.searchBar(search, selectedScopeButtonIndexDidChange: section ?? 0)
        search.selectedScopeButtonIndex = section ?? 0
        lista.reloadData()
    }
}

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

