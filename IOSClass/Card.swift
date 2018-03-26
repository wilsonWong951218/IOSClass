//
//  Card.swift
//  IOSClass
//
//  Created by Macintosh on 2018/3/12.
//  Copyright © 2018年 www. All rights reserved.
//

import Foundation
struct Card: Hashable
{
    var hashValue: Int{
        return identifier
    }

    static func ==(lhs: Card, rhs: Card) -> Bool {// lhs = left hand side , rhs = right hand side
        return lhs.identifier == rhs.identifier
    }

    var isFaceUp = false
    var isMatched = false
   private var identifier:Int//加了private後外部都叫不到
    static var identifireFactory = 0
    static func getUniqueIdentifire() -> Int{
        Card.identifireFactory += 1
        return Card.identifireFactory
    }
    /*init(identifier:Int){
        self.identifier = identifier
    }*/
   init(){
        identifier = Card.getUniqueIdentifire()
    }
}
