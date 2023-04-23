//
//  main.swift
//  MyCreditManager
//
//  Created by jiyeon on 2023/04/22.
//

import Foundation

class Student2 {
    let name: String
    var grades: [String: String] = [:]
    
    init(name: String) {
        self.name = name
    }
    
    func addGrade(subject: String, credit: String) {
        grades[subject] = credit;
    }
    
    func removeGrade(subject: String) -> String? {
        return grades.removeValue(forKey: subject)
    }
    
    func printAverage() {
        var total: Double = 0.0;
        
        for (subject, credit) in grades {
            print("\(subject): \(credit)")
            
            switch (credit) {
            case "A+": total += 4.5
            case "A": total += 4
            case "B+": total += 3.5
            case "B": total += 3
            case "C+": total += 2.5
            case "C": total += 2
            case "D+": total += 1.5
            case "D": total += 1
            default: break
            }
        }
        
        if (!grades.isEmpty) {
            print("평점 : \(String(format: "%.2f", total / Double(grades.count)))")
        }
    }
}

class CreditManager2 {
    var students: [Student2] = []
    
    /// 학생 추가
    func addStudent(name: String) {
        for student in students {
            if student.name == name {
                print("\(name)은(는) 이미 존재하는 학생입니다. 추가하지 않습니다.")
                return
            }
        }
        students.append(Student2(name: name))
        print("\(name) 학생을 추가했습니다.")
    }
    
    /// 학생 삭제
    func removeStudent(name: String) {
        for (idx, student) in students.enumerated() {
            if student.name == name {
                students.remove(at: idx)
                print("\(name) 학생을 삭제했습니다.")
                return
            }
        }
        print("\(name) 학생을 찾지 못했습니다.")
    }
    
    /// 성적 추가
    func addGrade(name: String, subject: String, credit: String) {
        for student in students {
            if student.name == name {
                student.addGrade(subject: subject, credit: credit)
                print("\(name) 학생의 \(subject) 과목이 \(credit)로 추가(변경)되었습니다.")
                return
            }
        }
        print("\(name) 학생을 찾지 못했습니다.")
    }
    
    /// 성적 삭제
    func removeGrade(name: String, subject: String) {
        for student in students {
            if student.name == name {
                if student.removeGrade(subject: subject) != nil {
                    print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
                } else {
                    print("\(name) 학생의 \(subject) 과목의 성적을 찾지 못했습니다.")
                }
                return
            }
        }
        print("\(name) 학생을 찾지 못했습니다.")
    }
    
    /// 평점 보기
    func printAverage(name: String) {
        for student in students {
            if student.name == name {
                student.printAverage()
                return ;
            }
        }
        print("\(name) 학생을 찾지 못했습니다.")
    }
}

func isValidInput(_ input: String) -> Bool {
    for c in input {
        if !c.isNumber || !c.isLowercase || !c.isUppercase {
            return false
        }
    }
    return true
}

let creditManager = CreditManager2()
var flag = true

while (flag) {
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    let input = readLine()
    
    switch(input) {
    case "1":
        print("추가할 학생의 이름을 입력해주세요.")
        if let name = readLine(), isValidInput(name) {
            creditManager.addStudent(name: name)
        } else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    case "2":
        print("삭제할 학생의 이름을 입력해주세요.")
        if let name = readLine() {
            creditManager.removeStudent(name: name)
        } else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    case "3":
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift A+")
        print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        let splitInput = readLine()?.components(separatedBy: " ")
        if splitInput?.count == 3, let name = splitInput?[0], let subject = splitInput?[1], let credit = splitInput?[2] {
            creditManager.addGrade(name: name, subject: subject, credit: credit)
        } else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    case "4":
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift")
        let splitInput = readLine()?.components(separatedBy: " ")
        if splitInput?.count == 2, let name = splitInput?[0], let subject = splitInput?[1] {
            creditManager.removeGrade(name: name, subject: subject)
        } else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    case "5":
        print("평점을 알고싶은 학생의 이름을 입력해주세요.")
        if let name = readLine() {
            creditManager.printAverage(name: name)
        } else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    case "X":
        print("프로그램을 종료합니다...")
        flag = false
    default:
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
}
