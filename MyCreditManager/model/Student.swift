//
//  Student.swift
//  MyCreditManager
//
//  Created by jiyeon on 2023/04/23.
//

import Foundation

class Student {
    
    let name: String
    var grade: [String: CreditType] = [:] // [Subject: Credit]
    
    init(_ name: String) {
        self.name = name
    }
    
}
