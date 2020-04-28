//
//  LoaderJson.swift
//  HairbS
//
//  Created by Paulo Uchôa on 26/04/20.
//  Copyright © 2020 HairbS-Team. All rights reserved.
//

import Foundation

public class LoaderJson {
    
    @Published var itemData = [ItemData]()
    
    init() {
        load()
        sort()
    }
    // Função que carrega o arquivo HairbS.json
    func load() {
        if let fileLocation = Bundle.main.url(forResource: "HairbS", withExtension: "json") {
            
            do{
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([ItemData].self, from: data)
                
                self.itemData = dataFromJson
            } catch {
                print (error)
            }
        }
    }
    // Ordena os nomes em ordem alfabética
    func sort() {
    
    self.itemData = self.itemData.sorted {
        var isSorted = false
        if let first = $0.nome, let second = $1.nome {
            isSorted = first < second
        }
        return isSorted
        }
    }
}
