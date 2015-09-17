//
//  URLTaskCache.swift
//  TestApp
//
//  Created by Serge Kutny on 9/17/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import Foundation

extension NSURLSessionTask {
    private func isSuitableForCache() -> Bool {
        return (NSURLSessionTaskState.Completed != self.state) &&
            (NSURLSessionTaskState.Canceling != self.state)
    }
}

class URLTaskCache {
    private var storage = [String: NSURLSessionTask]()
    
    func purge() {
        var newStorage = [String: NSURLSessionTask]()
        for (key, value) in storage {
            if value.isSuitableForCache() {
                newStorage[key] = value
            }
        }
        
        storage = newStorage
    }
    
    subscript(key: String) -> NSURLSessionTask? {
        set(task) {
            purge()
        
            guard (nil != task) && task!.isSuitableForCache() else {
                return
            }
            
            if let oldTask = storage[key] {
                oldTask.cancel()
            }
            
            storage[key] = task!
        }
        
        get {
            return storage[key]
        }
    }
    
    func cancel(key: String) {
        guard let value = storage[key] else {
            return
        }
        
        if (value.isSuitableForCache())
        {
            value.cancel()
        }
        
        storage[key] = nil
    }
    
    func cancelAll() {
        for key in storage.keys {
            cancel(key)
        }
    }
    
    deinit {
        cancelAll()
    }
}
