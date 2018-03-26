//
//  ViewController.swift
//  IOSClass
//
//  Created by Macintosh on 2018/3/12.
//  Copyright © 2018年 www. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var numberOfPairsCard:Int{
        
            return(flipCard.count+1)/2
        
    }
    
    //lazy當程式呼叫他是時才動作
    lazy var game = Concentration(numberofPairsCards: (numberOfPairsCard))
    
    var cardNumber = 0{

        didSet{
         updatacardNumberLabel()
//            LabelCounter.text="Count = \(cardNumber)"
        }
    }
    func updatacardNumberLabel(){
        let attributes:[NSAttributedStringKey:Any] = [
            .strokeWidth:5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.6605157144, blue: 0.1398423435, alpha: 1)
        ]
        let attributedString = NSAttributedString(string:"Count = \(cardNumber)", attributes: attributes)
        LabelCounter.attributedText = attributedString
    }
    
    @IBOutlet var flipCard: [UIButton]!
    
    @IBOutlet weak var LabelCounter: UILabel!{
        didSet{
            updatacardNumberLabel()
            
        }
    }
    
    @IBAction func card1(_ sender: UIButton) {
        
        if let cardnumber = flipCard.index(of:sender){
            
            if !game.cards[cardnumber].isMatched{
            cardNumber += 1
            }
            game.chooseCard(at: cardnumber)
            updateViewFromModel()
        }else{
            print("error")
        }
        
    }
    func updateViewFromModel(){
        for index in flipCard.indices{
            let button = flipCard[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for:UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else if card.isMatched{
                button.setTitle(emoji(for:card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2272313784)
            }else{
                button.setTitle("", for:UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.6605157144, blue: 0.1398423435, alpha: 1)
               
            }
        }
    }
    func resetViewFromModel(){
        for index in flipCard.indices{
            let button = flipCard[index]
            button.setTitle("", for:UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.6605157144, blue: 0.1398423435, alpha: 1)
            
        }
    }
    var emojiChoices = ["👻","🎃","☠️","👺","💩","🙀"]
    //var emoji = Dictionary<Int,String>()
    var emoji = Dictionary<Card,String>()//Card改為hashable後
    func emoji(for card:Card) -> String{
      /*  if emoji[card.identifier] != nil{
            return emoji[card.identifier]!
        }else{
       return "?"
    }
    return emoji[card.identifier] ?? "?"
 */
        if emoji[card] == nil && emojiChoices.count > 0{//card 通過hashable回傳了identifier
            /*if emojiChoices.count > 0{
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
             }*/
            
            emoji[card] = emojiChoices.remove(at:emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func resetButton(_ sender: UIButton) {
        game = Concentration(numberofPairsCards: numberOfPairsCard)
        resetViewFromModel()
        game.reset()
        cardNumber = 0
        emojiChoices = ["👻","🎃","☠️","👺","💩","🙀"]
    }
    

}
extension Int{//自己自造一個methods／computer properties到INT class 裡面
              //let x = 5.arc4random x = 0,1,2,3,4
    var arc4random:Int{
        if self > 0 {
        return Int(arc4random_uniform(UInt32(self)))
        }else if self<0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))

        }else{
            return 0
        }
    }
}
