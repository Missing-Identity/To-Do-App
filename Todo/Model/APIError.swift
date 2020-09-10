//
//  APIError.swift
//  Todo
//
//  Created by Unmilan on 10/09/20.
//  Copyright © 2020 Unmilan. All rights reserved.
//

import Foundation

struct APIError: Codable {//This is present cause in the API we have an error model.
    
    let message: String
}
