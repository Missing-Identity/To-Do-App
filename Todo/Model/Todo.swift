//
//  Todo.swift
//  Todo
//
//  Created by Unmilan on 10/09/20.
//  Copyright © 2020 Unmilan. All rights reserved.
//

import Foundation

struct Todos: Codable {
    
    let items: Array<Todo>//We do this as items is another object in the server file and it is an array of type Todo.
}

struct Todo: Codable {//Setting up struct to map data from server. Codeable allows us to read and write straight from API.
    
    let item: String
    let priority: Int//Be sure to name these the same as the properties in the API.
    
}


