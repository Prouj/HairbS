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
    
    let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    init() {
        
        load()
        sort()
    }
    
    func loadInicial() {
        if let fileLocation = Bundle.main.url(forResource: "HairbS", withExtension: "json") {
            do{
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([ItemData].self, from: data)

                self.itemData = dataFromJson
                
                save(update: self.itemData)
            } catch {
                print (error)
            }
        }
    }
    
    // Função que carrega o arquivo HairbS.json
    func load() {
        do {
            let data = try Data(contentsOf: directory.appendingPathComponent("HairbS.json"))
            let jsonDecoder = JSONDecoder()
            let dataFromJson = try jsonDecoder.decode([ItemData].self, from: data)
                           
            self.itemData = dataFromJson
        } catch {
            print (error)
        }

    }
    
    func save(update: [ItemData]) {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(update)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            let data = Data(json!.utf8)
            
            do {
                if FileManager.default.fileExists(atPath: directory.appendingPathComponent("HairbS.json").relativePath) {
                    try data.write(to: URL(fileURLWithPath: directory.appendingPathComponent("HairbS.json").relativePath))
                } else {
                    FileManager.default.createFile(atPath: directory.appendingPathComponent("HairbS.json").relativePath, contents: data, attributes: [:])
                }

                load()
                
            } catch {
                print(error.localizedDescription)
            }
        } catch {
            print(error)
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
