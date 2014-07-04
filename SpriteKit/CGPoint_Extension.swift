//
//  Vector2.swift
//  Flying Squircle
//
//  Created by Kevin Bi on 7/3/14.
//  Copyright (c) 2014 Kevelopment. All rights reserved.
//

import SpriteKit

extension CGPoint{
    init(_ x: CGFloat,_ y: CGFloat){
        self.x = x;
        self.y = y;
    }
    
    //Static functions for basic arithmetic operations
    static func add(a: CGPoint,_ b: CGPoint)-> CGPoint{return CGPoint(a.x + b.x, a.y + b.y);}
    static func minus(a: CGPoint,_ b: CGPoint)-> CGPoint{return CGPoint(a.x - b.x, a.y - b.y);}
    static func multiply(a: CGPoint,_ b: CGFloat)-> CGPoint{return CGPoint(a.x * b, a.y * b);}
    static func divide(a: CGPoint,_ b: CGFloat)-> CGPoint{return CGPoint(a.x / b, a.y / b);}
    static func equals(a: CGPoint,_ b: CGPoint)-> Bool{return a.x == b.x && a.y == b.y;}
    
    //Instance functions of arithmetic operators
    mutating func add(b: CGPoint)-> CGPoint{self = CGPoint.add(self, b); return self;}
    mutating func minus(b: CGPoint)-> CGPoint{self = CGPoint.minus(self, b); return self;}
    mutating func multiply(b: CGFloat)-> CGPoint{self = CGPoint.multiply(self, b); return self;}
    mutating func divide(b: CGFloat)-> CGPoint{self = CGPoint.divide(self, b); return self;}
    func equals(b: CGPoint)-> Bool{return CGPoint.equals(self, b);}
    
    //Static and instance normalize functions
    static func normalize(p: CGPoint)-> CGPoint{
        if(p.x == 0 && p.y == 0) {
            return p;
        }
        var mag = sqrtf((p.x * p.x) + (p.y * p.y));
        return CGPoint(p.x / mag, p.y / mag);
    }
    mutating func normalize()->CGPoint{self = CGPoint.normalize(self); return self;}
}

//Operators
@infix func + (left: CGPoint, right: CGPoint)-> CGPoint{return CGPoint.add(left, right);}
@infix func - (left: CGPoint, right: CGPoint)-> CGPoint{return CGPoint.minus(left, right);}
@infix func * (left: CGPoint, right: CGFloat)-> CGPoint{return CGPoint.multiply(left, right);}
@infix func / (left: CGPoint, right: CGFloat)-> CGPoint{return CGPoint.divide(left, right);}

//Assignment Operators
@assignment func += (inout a: CGPoint, b: CGPoint){a = a + b;}
@assignment func -= (inout a: CGPoint, b: CGPoint){a = a - b;}
@assignment func *= (inout a: CGPoint, b: CGFloat){a = a * b;}
@assignment func /= (inout a: CGPoint, b: CGFloat){a = a / b;}

//Equivalence Operators
@infix func == (a: CGPoint, b: CGPoint)-> Bool{return a.equals(b);}
@infix func != (a: CGPoint, b: CGPoint)-> Bool{return !(a == b);}
