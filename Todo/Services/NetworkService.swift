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
    
    func getTodos(onSuccess: @escaping (Todos) -> Void, onError: @escaping (String) -> Void) {//escaping is basically here for it to leave the function here and then we pass back Todos when network request is done. Since this closure is not returning anything and is just passing a parameter, we don't need a return statement.
        
        let url = URL(string: "\(URL_BASE)")!//Creating url to use it in our URL session. We are force unwrapping as we already have a local server, if it was a dynamic url it wouldn't be required.
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {//Whatever is inside here will run on the UI thread instead of background thread.
                if let error = error {//We grab the error passed from above here.
                    debugPrint(error.localizedDescription)//Returning error description.
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }//Returns empty if data is nil or response is nil.
                
                do {//Remember that everytime we do a try, we need to keep it within a do and catch block.
                    
                    if response.statusCode == 200 {
                        //parse successful result(Todos)
                        let items = try JSONDecoder().decode(Todos.self, from: data)//Decoding Todo item
                        onSuccess(items)
                        //Handle success
                        
                    } else {
                        //Show error to user.
                        let err = try JSONDecoder().decode(APIError.self, from: data)//Taking error from data.
                        
                        //Handle error
                        onError(err.message)//Giving out API's message.
                    }
                    
                }
                catch {
                    
                    onError(error.localizedDescription)
                    
                }
                
            }
            
        }//We are creating a data task. We pass in the url. After the request is done, we will get back data, response and errors. PS: pick dataTask with completionHandler as we aren't downloading anything.
        task.resume()//Starting task.
    }
    
    func addTodo(todo: Todo, onSuccess: @escaping (Todos) -> Void, onError: @escaping (String) -> Void) {
        let url = URL(string: "\(URL_BASE)\(URL_ADD_TODO)")!
        var request = URLRequest(url: url)//This allows us to add more information to the request before sending it out. We need to do this for POST requests as the default is GET.
        request.httpMethod = "POST"//POST means add new item.
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")//These are Headers for your request. What you are doing here is that you are letting the server know what kind of data is coming through.
        request.addValue("application/json", forHTTPHeaderField: "Accept")//Basically here we are telling our application know that we are passing in json type of data with the addValue methods.
        
        do{
            let body = try JSONEncoder().encode(todo)//body means the body of the http. Check the server for this. Encoding means converting our swift file to a JSON.
            request.httpBody = body//So after we converted our todo object into JSON, we stuff it into the http body of the url request using this statement.
            
            let task = session.dataTask(with: request) { (data, response, error) in//Remember to pick the one with URLRequest and completion handler unlike just URL like for the GET task.
                
                DispatchQueue.main.async {//Putting our data into the Main/UI thread. Or else it will run on the background thread.
                    if let error = error {
                        //error
                        onError(error.localizedDescription)//If there is an error with encoding our data then this error message will be shown.
                        return
                    }
                    guard let data = data, let response = response as? HTTPURLResponse else {
                        //error
                        onError("Failed to get data from server.")//If there is no data from server, this is the message that will be shown.
                        return
                    }
                    
                    do{
                        if response.statusCode == 200{
                            let items = try JSONDecoder().decode(Todos.self, from: data)
                            //onSuccess
                            onSuccess(items)
                        } else {
                            let err = try JSONDecoder().decode(APIError.self, from: data)
                            //onError
                            onError(err.message)//Displays error from our API.
                        }
                        
                    } catch {
                        //error
                        onError(error.localizedDescription)//This is the error we get if the JSON decoding fails.
                    }
                }
            }
            task.resume()
        } catch {
            //error
            onError(error.localizedDescription)//This catches any other type of error that might occur.
        }
    }
    
    
}
