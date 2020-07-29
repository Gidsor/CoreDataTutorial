//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Vadim Denisov on 28.07.2020.
//  Copyright © 2020 Vadim Denisov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }


}

