//
//  main.swift
//  MyCreditManager
//
//  Created by jiyeon on 2023/04/23.
//

import Foundation

let manager = CreditManager()
var loop = true

while loop {
    print("원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    
    guard let input = readLine() else {
        print("입력이 잘못되었습니다.")
        break
    }
    
    switch input {
    case "1":
        manager.addStudent()
    case "2":
        manager.deleteStudent()
    case "3":
        manager.addGrade()
    case "4":
        manager.deleteGrade()
    case "5":
        manager.printAverage()
    case "X", "x":
        print("프로그램을 종료합니다...")
        loop = false
    default:
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
}
