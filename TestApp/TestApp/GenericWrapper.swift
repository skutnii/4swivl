//
//  GenericWrapper.swift
//  TestApp
//
//  Created by Serge Kutny on 9/18/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import Foundation

class GenericWrapper<T> {
    private var _value : T?
    
    subscript () -> T? {
        get {
            return _value
        }
        set (value) {
            _value = value
        }
    }
    
    init(value: T?) {
        _value = value
    }
}
