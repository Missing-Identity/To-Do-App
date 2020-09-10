//
//  ViewController.swift
//  Todo
//
//  Created by Unmilan on 10/09/20.
//  Copyright © 2020 Unmilan. All rights reserved.
//

import UIKit

class TodoVc: UIViewController {

    @IBOutlet weak var todoItemTxt: UITextField!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.shared.getTodos()
    }

    @IBAction func addTodo(_ sender: Any) {
    }
    
}

