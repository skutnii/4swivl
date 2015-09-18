//
//  Geometry.swift
//  TestApp
//
//  Created by Serge Kutny on 9/18/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import UIKit

struct Point {
    var x : Double = 0
    var y : Double = 0
    
    init(_ OSPoint: CGPoint) {
        x = Double(OSPoint.x)
        y = Double(OSPoint.y)
    }
    
    init() {
    }
    
    func OSPoint() -> CGPoint {
        return CGPointMake(CGFloat(x), CGFloat(y))
    }
}

struct Size {
    var width : Double = 0
    var height : Double = 0
    
    init(_ OSSize: CGSize) {
        width = Double(OSSize.width)
        height = Double(OSSize.height)
    }
    
    init() {
    }
    
    func OSSize() -> CGSize {
        return CGSizeMake(CGFloat(width), CGFloat(height))
    }
}

struct Rect {
    var origin = Point()
    var size = Size()
    
    init() {
    }
    
    init(_ OSRect: CGRect) {
        origin = Point(OSRect.origin)
        size = Size(OSRect.size)
    }
    
    func OSRect() -> CGRect {
        return CGRectMake(
            CGFloat(origin.x),
            CGFloat(origin.y),
            CGFloat(size.width),
            CGFloat(size.height)
        )
    }
}