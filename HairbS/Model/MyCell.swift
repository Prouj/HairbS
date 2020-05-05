//
//  NibProtocol.swift
//  Inicial
//
//  Created by Paulo Uchôa on 30/04/20.
//  Copyright © 2020 Larissa Uchoa. All rights reserved.
//

import UIKit


protocol MyCell: UICollectionViewCell {
    static var identifier: String { get }
    static func nib() -> UINib
    func configure(with data: ItemData)
    func getName() -> String
}
