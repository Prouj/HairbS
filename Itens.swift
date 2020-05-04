//
//  Itens.swift
//  HairbS
//
//  Created by Paulo Uchôa on 04/05/20.
//  Copyright © 2020 HairbS-Team. All rights reserved.
//

import Foundation

// Struct que contem a estrutura do Json
// Extende o protocolo Codable, para permitir que o Json seja decodificado
struct ItemData: Codable {
    var popular: Bool?
    var nome: String?
    var nomeCientifico: String?
    var tipo: String?
    var favorito: Bool?
    var text: String?
    var cabelo: String?
    var pele: String?
    var fonte: String?
    var minText: String?
    var nomeImagem: String?
    var fonteImagem: String?
    var nomeImagemPopular: String?
}
