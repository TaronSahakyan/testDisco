//
//  TagsDataProvider.swift
//  TestDisco
//
//  Created by Taron on 19.09.22.
//

import Foundation

enum ChangeType {
    case initial
    case loadMore
    case error
}

protocol Response: Decodable {
    associatedtype ModelType: Decodable
    var data: [ModelType] { get }
}

protocol DataProvider {
    associatedtype ModelType:Decodable
    
    typealias Listener = (ChangeType, Error?) -> Void

    var data: ModelType { get }
    
    func addListener(listener:@escaping Listener)
}

class BaseDataProvider<T:Response>: DataProvider {
    
    var data:[T.ModelType] = []
    var nextPageURLString:String?
    var isLoading: Bool
    var url:URL
    var listeners:[Listener] = []
    
    
    init(with url:URL) {
        self.url = url
        isLoading = false
    }
    
    func initialRequest(){
        
        let completion:((T?, Error?) -> Void) = {[weak self] (result:T?, error:Error?) in
            
            guard let self = self else {
                return
            }
            
            if let _ = error {
                self.callListeners(changeType: .error, error: error)
                return
            }
            
            if let result = result {
                self.data = result.data
                self.callListeners(changeType: .initial)
            } else {
                self.callListeners(changeType: .initial)
            }

        }
        RequestManager.getRequest(with: url, completion: completion)
    }
    
    func callListeners(changeType:ChangeType, error:Error? = nil) {
        for listener in self.listeners {
            listener(changeType, error)
        }
    }
    
    func addListener(listener: @escaping Listener) {
        listeners.append(listener)

    }
    
}
