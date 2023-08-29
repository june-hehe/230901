//
//  Todo.swift
//  TodoCode
//
//  Created by DJ S on 2023/08/28.
//

import UIKit

// (커스텀) 델리게이트 패턴 구현을 위한 프로토콜 선언
protocol TodoDelegate: AnyObject {
    func addNewTodo(_ todo: Todo)
    func update(index: Int, _ todo: Todo)
}


struct Todo {
    // 투두의 (절대적) 순서를 위한 타입 저장 속성
//    static var todoNumbers: Int = 0
    
//    let todoId: Int
    var title: String?
    var content: String?
    init(title: String? ,content: String?) {
//
//        // 타입 저장속성에 저장되어 있는 값으로 순번 메기기
//        self.todoId = Todo.todoNumbers
        self.title = title
        self.content = content
//
//        // 투두를 생성한다면, 항상 타입 저장속성의 정수값 + 1
//        Todo.todoNumbers += 1
    }
}



