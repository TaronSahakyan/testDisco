//
//  RequestManager.swift
//  TestDisco
//
//  Created by Taron on 19.09.22.
//

import Foundation

enum ReqError:Error {
    case noData
}

enum RequestManager {
    static func getRequest<T:Decodable>(with url: URL, completion:@escaping (T?, Error?) -> Void) {

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil,error)
                return
            }
            
            if let data = data {
                
                let decoder = JSONDecoder.init()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try decoder.decode(T.self, from: data)
                    completion(result, nil)
                } catch (let error) {
                    completion(nil, error)
                }
                
            } else {
                completion(nil, ReqError.noData)
                return
            }
        }
        task.resume()
    }
}
 
