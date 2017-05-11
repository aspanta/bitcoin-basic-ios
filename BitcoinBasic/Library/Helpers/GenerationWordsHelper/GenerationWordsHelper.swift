//
//  GenerationWordsHelper.swift
//  EmercoinBasic
//

import UIKit

private let words = ["hand","eye","head","face","people","heart","home","always","another","ask","against","almost","voice","mother","father","miss","turn","long","new","each","yes","why","while","though","night","year","house","even","still","because","want","seem","through","last","yet","away","between","under","off","end","name","place","thing","enough","look","may","course","three","own","door","hand","eye","head","face","people","heart","home","always","another","ask","against","almost","voice","mother","father","miss","turn","long","new","each","yes","why","while","though","night","year","house","even","still","because","want","seem","through","last","yet","away","between","under","off","end","name","place","thing","enough","look","may","course","three","own","door","right","light","world","young","these","those","myself","life","without","round","must","might","something","many","quite","work","same","ever","room","anything","side","few","far","feel","around","half","every","dear","moment","nothing","once","most","better","oh","left","sir","lady","woman","begin","get","take","let","Mrs","tell","put","find","give","hear","stand","set"]


class GenerationWordsHelper: NSObject {

    class func generateWord() -> String {
     
        let number = Int(arc4random_uniform(100))
        
        return words[number]
    }
}
