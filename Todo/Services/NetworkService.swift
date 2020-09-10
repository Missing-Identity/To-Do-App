//
//  NetworkService.swift
//  Todo
//
//  Created by Unmilan on 10/09/20.
//  Copyright © 2020 Unmilan. All rights reserved.
//

import Foundation

class NetworkService {//Creating singleton. It basically is a shared instance in the application..
    static let shared = NetworkService()
    
    let URL_BASE = "http://localhost:3003"//Setting up the URL base.
    let URL_ADD_TODO = "/add"//This is the endpoint in the API to add Todos.
    
    let session = URLSession(configuration: .default)//Creating a URL session. URL session is a network management session. Default config to keep things simple for now.
    
    func getTodos() {
        
        let url = URL(string: "\(URL_BASE)")!//Creating url to use it in our URL session. We are force unwrapping as we already have a local server, if it was a dynamic url it wouldn't be required.
        
        let task = session.dataTask(with: url) { (data, response, error) in
             
            if let error = error {//We grab the error passed from above here.
                debugPrint(error.localizedDescription)//Returning error description.
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                debugPrint("Invalid data or response")
                return
            }//Returns empty if data is nil or response is nil.
            
            do {//Remember that everytime we do a try, we need to keep it within a do and catch block.
                
                if response.statusCode == 200 {
                    //parse successful result(Todos)
                    let items = try JSONDecoder().decode(Todos.self, from: data)//Decoding Todo item
                    print(items)
                    //Handle success
                    
                } else {
                    //Show error to user.
                    let err = try JSONDecoder().decode(APIError.self, from: data)//Taking error from data.
                    
                    //Handle error
                }
                
            }
            catch {
                
                debugPrint(error.localizedDescription)
                
            }
            
        }//We are creating a data task. We pass in the url. After the request is done, we will get back data, response and errors. PS: pick dataTask with completionHandler as we aren't downloading anything.
        task.resume()//Starting task.
    }
    
    func addTodo(todo: Todo) {
        
    }
    
    
}
