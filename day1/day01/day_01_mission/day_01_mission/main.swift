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

var tempX: Int = 0
var tempY: Int = 0
var targetX: Int
var targetY: Int

// 입력 받는 부분
if let words: String = readLine()! {
    
    var resultWords: String = ""
    var inputCheck: Bool = false
    
    // input만큼 돌면서 draw 하기
    for targetWord in words {
        (targetX,targetY) = findDirect(targetWord: String(targetWord))
        
        // 키보드를 넘어가는 입력을 받았을시
        if targetX < 0 || targetY < 0 || targetX >= keyboardRow || targetY >= keyboardCor {
            inputCheck = true
            break
        }
        
        //움직여야할 칸수 찾기
        let (intervalX,intervalY) = findInterval(tempX: tempX, tempY: tempY, targetX: targetX, targetY: targetY, resultWords: resultWords)
        
        if intervalX != 0 {
            resultWords += drawUpDown(intervalX: intervalX)
        }
        if intervalY != 0 {
            resultWords += drawRightLeft(intervalY: intervalY)
        }
        
        //이동
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

// 키보드에서 target 위치 찾기 메소드
func findDirect(targetWord: String) -> (Int, Int) {
    
    for x in 0..<keyboardRow {
        for y in 0..<keyboardCor {
            if keyboard[x][y] == targetWord{
                return (x,y)
            }
        }
    }
    
    // 잘못된 입력일시 출력
    return (-1,-1)
}

// 움직일 칸수 구하는 메소드
func findInterval(tempX: Int, tempY: Int, targetX: Int, targetY: Int, resultWords: String) -> (Int, Int) {
    
    let intervalX = tempX - targetX
    let intervalY = tempY - targetY
    
    return (intervalX, intervalY)
}

// 상하 그리기
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
    
// 좌우 그리기
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
