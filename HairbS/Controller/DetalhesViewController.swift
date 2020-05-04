//
//  DetalhesViewController.swift
//  HairbS
//
//  Created by Nathália Cardoso on 30/04/20.
//  Copyright © 2020 HairbS-Team. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var detalhesTextView: UITextView!
    
    var detalhes:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.cornerRadius = 20
        
        detalhesTextView.text = detalhes
        
        navigationItem.largeTitleDisplayMode = .never //pra não aparecer o espaço do large title
        
        // Do any additional setup after loading the view.
    }

}
