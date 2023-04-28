//
//  CreditManager.swift
//  MyCreditManager
//
//  Created by jiyeon on 2023/04/23.
//

import Foundation

class CreditManager {

    private var students: [String: Student] = [:]
    
    // 학생 추가 메소드
    func addStudent() {
        guard let name = getInput(.addStudent) else { return }
        if checkValid(name) == false {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        if self.students.contains(where: { $0.key == name }) {
            print("\(name)은(는) 이미 존재하는 학생입니다. 추가하지 않습니다.")
        } else {
            self.students[name] = Student(name)
            print("\(name) 학생을 추가했습니다.")
        }
    }
    
    // 학생 삭제 메소드
    func deleteStudent() {
        guard let name = getInput(.deleteStudent) else { return }
        
        if checkExist(name) {
            self.students.removeValue(forKey: name)
            print("\(name) 학생을 삭제했습니다.")
        }
    }
    
    // 성적 추가/변경 메소드
    func addGrade() {
        guard let input = getInput(.addGrade) else { return }
        
        let splitInput = input.components(separatedBy: " ")
        if splitInput.count != 3 || !checkValid(splitInput[1])
            || CreditType(rawValue: splitInput[2].uppercased()) == nil {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        let name = splitInput[0]
        let subject = splitInput[1]
        let credit = splitInput[2]
        if checkExist(name) {
            self.students[name]?.grade[subject] = CreditType(rawValue: credit.uppercased())
            print("\(name) 학생의 \(subject) 과목이 \(credit.uppercased())로 추가(변경)되었습니다.")
        }
    }
    
    // 성적 삭제 메소드
    func deleteGrade() {
        guard let input = getInput(.deleteGrade) else { return }
        
        let splitInput = input.components(separatedBy: " ")
        if splitInput.count != 2 {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        let name = splitInput[0]
        let subject = splitInput[1]
        if checkExist(name) {
            if (self.students[name]?.grade.removeValue(forKey: subject) != nil) {
                print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
            } else {
                print("\(name) 학생의 \(subject) 과목을 찾지 못했습니다.")
            }
        }
    }

    // 평점 보기 메소드
    func printAverage() {
        guard let name = getInput(.printAverage) else { return }
        
        if (checkExist(name)), let grade = self.students[name]?.grade {
            if (grade.isEmpty) {
                print("성적이 존재하지 않는 학생입니다.")
            } else {
                var total = 0.0
                
                for (subject, credit) in grade {
                    print("\(subject): \(credit.rawValue)")
                    total += credit.toDouble
                }
                print("평점 : \(String(format: "%.2f", total / Double(grade.count)))")
            }
        }
    }
    
    // InputType에 해당하는 메시지를 출력한 후 입력을 받는 메소드
    private func getInput(_ inputType: InputType) -> String? {
        print(inputType.toMessage)
        guard let input = readLine() else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return nil
        }
        return input
    }
    
    // 문자열이 숫자 또는 영어인지 확인하는 메소드
    private func checkValid(_ str: String) -> Bool {
        if (str.contains(where: { !$0.isNumber && !$0.isUppercase && !$0.isLowercase })) {
            return false
        } else {
            return true
        }
    }
    
    // 학생 배열에 이름이 name인 학생이 있는지 확인하는 메소드
    private func checkExist(_ name: String) -> Bool {
        if self.students.contains(where: { $0.key == name }) {
            return true
        } else {
            print("\(name) 학생을 찾지 못했습니다.")
            return false
        }
    }
    
}
