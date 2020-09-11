//
//  TodoCell.swift
//  Todo
//
//  Created by Unmilan on 10/09/20.
//  Copyright © 2020 Unmilan. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {
    
    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var priorityView: UIView!

    func updateCell(todo: Todo) {//Checking priority of data and setting cell background.
        
        itemLbl.text = todo.item
        
        switch todo.priority {
        case 0:
            priorityView.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            break
        case 1:
            priorityView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            break
        default:
            priorityView.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
    }

}
