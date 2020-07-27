//
//  main.swift
//  day_01_mission
//
//  Created by 정승범 on 2020/07/27.
//  Copyright © 2020 정승범. All rights reserved.
//

import Foundation

let keyboard: [[String]] = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                            ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
                            ["A", "S", "D", "F", "G", "H", "J", "K", "L", ";"],
                            ["Z", "X", "C", "V", "B", "N", "M", ",", ".", "?"]]

let keyboardRow: Int = keyboard.count;
let keyboardCor: Int = keyboard[0].count;

//상하가 우선 좌우가 나중

var tempX: Int = 0
var tempY: Int = 0
var targetX: Int
var targetY: Int


if let words: String = readLine()! {
    
    var resultWords: String = ""
    var inputCheck: Bool = false
    
    for targetWord in words {
        (targetX,targetY) = findDirect(targetWord: String(targetWord))
        
        if targetX < 0 || targetY < 0 || targetX >= keyboardRow || targetY >= keyboardCor {
            inputCheck = true
            break
        }
        
        let (intervalX,intervalY) = findInterval(tempX: tempX, tempY: tempY, targetX: targetX, targetY: targetY, resultWords: resultWords)
        
        if intervalX != 0 {
            resultWords += drawUpDown(intervalX: intervalX)
        }
        if intervalY != 0 {
            resultWords += drawRightLeft(intervalY: intervalY)
        }
        
        tempX = targetX
        tempY = targetY
        
        resultWords += "@"
    }
    
    if(!inputCheck){
        print(resultWords)
    } else {
        print("Input Error!")
    }
} else {
    print("Input nil!")
}

func findDirect(targetWord: String) -> (Int, Int) {
    
    for x in 0..<keyboardRow {
        for y in 0..<keyboardCor {
            if keyboard[x][y] == targetWord{
                return (x,y)
            }
        }
    }
    
    return (-1,-1)
}

func findInterval(tempX: Int, tempY: Int, targetX: Int, targetY: Int, resultWords: String) -> (Int, Int) {
    
    let intervalX = tempX - targetX
    let intervalY = tempY - targetY
    
    return (intervalX, intervalY)
}

func drawUpDown(intervalX: Int) -> String {
    var tmpResultWords : String = ""
    
    if intervalX > 0 {
        for _ in 1...intervalX{
            tmpResultWords += "^"
        }
    } else {
        for _ in 1...(intervalX * -1){
            tmpResultWords += "_"
        }
    }
    
    return tmpResultWords
}
    

func drawRightLeft(intervalY: Int) -> String {
    var tmpResultWords : String = ""
    
    if intervalY > 0 {
        for _ in 1...intervalY{
            tmpResultWords += "<"
        }
    } else {
        for _ in 1...(intervalY * -1){
            tmpResultWords += ">"
        }
    }
    
    return tmpResultWords
}
