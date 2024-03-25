//
//  NetworkResponce.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 20.03.2024.
//

import Foundation

struct NetworkResponce: Decodable {
    let error: NetworkError?
    let data: Data?
    
    init(error: NetworkError? = nil, data: Data? = nil) {
        self.error = error
        self.data = data
    }
}
