//
//  Controller.swift
//  IOSClass
//
//  Created by Macintosh on 2018/3/12.
//  Copyright © 2018年 www. All rights reserved.
//

import Foundation
struct Concentration{
    var counter = 0;
    var cards = [Card]()
    var indexOfOneAndOnlyfaceUpCard: Int?{
        get{
            var foundCard:Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundCard == nil{
                        foundCard = index
                    }else{
                        return nil
                    }
                }
                
            }
            return foundCard
        }
        set(newvalue){
            for index in cards.indices{
                if index == newvalue {
                    cards[index].isFaceUp = true
                }else{
                    cards[index].isFaceUp = false
                }
                //cards[index].isFaceUp = (index == newvalue)
            }
        }
    }
    
    func shuffleArray<type>(originalArray:[type]) -> [type]{
        var numberOfArray = originalArray.count
        var finalArray = originalArray
        while numberOfArray > 1 {
            let numberOfArrayNew = Int(arc4random_uniform(UInt32(numberOfArray)))
            let tempThing = finalArray[numberOfArray-1]
            finalArray[numberOfArray-1] = finalArray[numberOfArrayNew]
            finalArray[numberOfArrayNew] = tempThing
            numberOfArray = numberOfArray - 1
        }
        return finalArray
        
    }
    
   mutating func reset(){
        indexOfOneAndOnlyfaceUpCard = nil
        counter = 0
        for index in cards.indices{
            cards[index].isMatched = false
            cards[index].isFaceUp = false
        }
    }
    
   mutating func chooseCard(at index:Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyfaceUpCard,index != matchIndex {
                //if cards[matchIndex].identifier == cards[index].identifier{
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    counter = 0
                }
                cards[index].isFaceUp = true
            }else if index == indexOfOneAndOnlyfaceUpCard {
                cards[index].isFaceUp = false
            }else{
                counter += 1
               counter = chackThe3rdCardNeedFlidOrNot(counter: counter, index: index)
            }
        }
   
    }
   mutating func chackThe3rdCardNeedFlidOrNot(counter coun:Int,index number:Int)->(Int){
        if coun <= 1{
            if cards[number].isFaceUp == true{
             indexOfOneAndOnlyfaceUpCard = nil
                    return  0
            }else{
                indexOfOneAndOnlyfaceUpCard = number
                return 0
            }
        }
        return coun
    }
    
   init(numberofPairsCards: Int){
   
    for _ in 1...numberofPairsCards{
            let card = Card()
        //var carda = shuffleArray(originalArray: cards)
        //let card = Card(identifier:identifier)
        //let matchingCard = card
           // var newcard = shuffleArray(originalArray: cards)
            //cards.append(card)
            //cards.append(matchingCard)
            cards +=  [card,card]
            
        }
    cards = shuffleArray(originalArray: cards)
    }
}
