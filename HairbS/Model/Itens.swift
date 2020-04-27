//
//  Itens.swift
//  HairbS
//
//  Created by Paulo Uchôa on 26/04/20.
//  Copyright © 2020 HairbS-Team. All rights reserved.
//

import Foundation

// Struct que contem a estrutura do Json
// Extende o protocolo Codable, para permitir que o Json seja decodificado
struct ItemData: Codable {
    var nome: String?
    var nomeCientifico: String?
    var tipo: String?
    var favorito: Bool?
    var text: String?
    var cabelo: String?
    var pele: String?
    var fonte: String?
}
