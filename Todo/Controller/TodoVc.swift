//
//  ViewController.swift
//  Todo
//
//  Created by Unmilan on 10/09/20.
//  Copyright © 2020 Unmilan. All rights reserved.
//

import UIKit

class TodoVc: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var todoItemTxt: UITextField!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var todoTable: UITableView!
    
    var todos = Array<Todo>()//Initialising as 0 so that if data isn't ready yet it will show 0 cells instead of crashing.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTable.delegate = self
        todoTable.dataSource = self
        
        getTodos()
        
//        NetworkService.shared.addTodo(todo: Todo(item: "TEST", priority: 2), onSuccess: { (todos) in
//
//            self.todos = todos.items
//            self.todoTable.reloadData()
//
//        }) { (errorMessage) in
//
//        }
        
        //ALL THE LINES ABOVE CAN BE WRITTEN IF YOU WANT TO TEST THE POST REQUEST MANUALLY AND NOT VIA UI.
        
    }
    
    func getTodos() {
        
        NetworkService.shared.getTodos(onSuccess: { (todos) in
             self.todos = todos.items//This replaces the todos array values to whatever we get from the server. We keep .items here because that is where we stored our array of Todo. Check Todo.swift file for this.
             self.todoTable.reloadData()
        }) { (errorMessage) in
             debugPrint(errorMessage)//Error Handling
        }
    }

    @IBAction func addTodo(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TodoCell {
            cell.updateCell(todo: todos[indexPath.row])//Passing in appropriate cell.
            return cell
        }
        return UITableViewCell()//In case app doesn't have cells ready this will make a blank view atleast.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
}

