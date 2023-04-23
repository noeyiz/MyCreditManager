//
//  CreditManager.swift
//  MyCreditManager
//
//  Created by jiyeon on 2023/04/23.
//

import Foundation

class CreditManager {

    var students: [String: Student] = [:]
    
    func addStudent() {
        guard let name = getInput(.addStudent) else { return }
        
        if students.contains(where: { $0.key == name }) {
            print("\(name)은(는) 이미 존재하는 학생입니다. 추가하지 않습니다.")
        } else {
            students[name] = Student(name)
            print("\(name) 학생을 추가했습니다.")
        }
    }
    
    func deleteStudent() {
        guard let name = getInput(.deleteStudent) else { return }
        
        if checkExist(name) {
            students.removeValue(forKey: name)
            print("\(name) 학생을 삭제했습니다.")
        }
    }
    
    func addGrade() {
        guard let input = getInput(.addGrade) else { return }
        
        let splitInput = input.components(separatedBy: " ")
        if splitInput.count != 3 || CreditType(rawValue: splitInput[2].uppercased()) == nil {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        if checkExist(splitInput[0]) {
            students[splitInput[0]]?.info[splitInput[1]] = splitInput[2].uppercased()
            print("\(splitInput[0]) 학생의 \(splitInput[1]) 과목이 \(splitInput[2])로 추가(변경)되었습니다.")
        }
    }
    
    func deleteGrade() {
        guard let input = getInput(.deleteGrade) else { return }
        
        let splitInput = input.components(separatedBy: " ")
        if splitInput.count != 2 {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        if checkExist(splitInput[0]) {
            students[splitInput[0]]?.info.removeValue(forKey: splitInput[1])
            print("\(splitInput[0]) 학생의 \(splitInput[1]) 과목의 성적이 삭제되었습니다.")
        }
    }

    func printAverage() {
        guard let name = getInput(.printAverage) else { return }
        
        if (checkExist(name)), let info = students[name]?.info {
            var total = 0.0
            
            for (subject, score) in info {
                print("\(subject): \(score)")
                total += CreditType(rawValue: score)?.toDouble ?? 0
            }
            print("평점 : \(String(format: "%.2f", total / Double(info.count)))")
        }
    }
    
    private func getInput(_ inputType: InputType) -> String? {
        print(inputType.toMessage)
        guard let input = readLine() else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return nil
        }
        if input.isEmpty || checkValid(input) == false {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return nil
        }
        return input
    }
    
    private func checkValid(_ str: String) -> Bool {
        if (str.contains(where: { !$0.isNumber && !$0.isUppercase && !$0.isLowercase })) {
            return false
        } else {
            return true
        }
    }
    
    private func checkExist(_ name: String) -> Bool {
        if students.contains(where: { $0.key == name }) {
            return true
        } else {
            print("\(name) 학생을 찾지 못했습니다.")
            return false
        }
    }
    
}
