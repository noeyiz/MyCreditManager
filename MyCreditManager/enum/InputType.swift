//
//  InputType.swift
//  MyCreditManager
//
//  Created by jiyeon on 2023/04/23.
//

import Foundation

enum InputType {
    
    case addStudent
    case deleteStudent
    case addGrade
    case deleteGrade
    case printAverage
    
    var toMessage: String {
        switch self {
        case .addStudent:
            return "추가할 학생의 이름을 입력해주세요."
        case .deleteStudent:
            return "삭제할 학생의 이름을 입력해주세요."
        case .addGrade:
            return "성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift A+\n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다."
        case .deleteGrade:
            return "성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift"
        case .printAverage:
            return "평점을 알고싶은 학생의 이름을 입력해주세요."
        }
    }
    
}
