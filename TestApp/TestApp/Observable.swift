//
//  Observable.swift
//  TestApp
//
//  Created by Serge Kutny on 9/17/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import Foundation

class Callback<T, O : AnyObject> {
    typealias Call = (T?, T?, AnyObject) -> ()
    typealias Owner = Observable<T, O>
    private let _call : Call
    private let _observable : Owner
    private init(call: Call, owner: Owner) {
        _call = call
        _observable = owner
    }
    
    func unlink() {
        let index = _observable._callbacks.indexOf({ (value) in value === self})
        if nil != index {
            _observable._callbacks.removeAtIndex(index!)
        }
    }
}

class Observable<T, O : AnyObject> : GenericWrapper<T> {
    private unowned let _owner : O
    
    private var _callbacks = [Callback<T, O>]()
    
    private func _didChange(from oldValue: T?, to newValue:T?) {
        for callback in _callbacks {
            callback._call(oldValue, newValue, _owner)
        }
    }

    override subscript () -> T? {
        get {
            return super[]
        }
        set (value) {
            let oldValue = super[]
            super[] = value
            _didChange(from: oldValue, to: value)
        }
    }
    
    func addObserver(call: Callback<T, O>.Call) -> Callback<T, O> {
        let callback = Callback<T, O>(call: call, owner: self)
        _callbacks.append(callback)
        callback._call(nil, self[], _owner)
        return callback
    }
    
    func removeObserver(observer: Callback<T, O>?) {
        guard  let index = _callbacks.indexOf({ (value) in value === observer}) else {
            return
        }
        
        _callbacks.removeAtIndex(index)
    }
   
    init(owner: O, value: T?) {
        _owner = owner
        super.init(value: value)
    }
}
