//
//  TodoListMananger.swift
//  TodoCode
//
//  Created by DJ S on 2023/08/28.
//

import Foundation

final class TodoListManager {
    
    private var todoList: [Todo] = []
    
    func makeTodoListDatas() {
        todoList = [
        ]
    }
    // 전체 Todo 리스트 얻기
    func getTodoList() -> [Todo] {
        return todoList
    }
    
    // 새로운 Todo 만들기
    func makeNewTodo(_ todo: Todo) {
        todoList.append(todo)
    }
    
    // 기존 Todo 정보 업데이트
    func updateTodoInfo(index: Int, _ todo: Todo) {
        todoList[index] = todo
    }
    
    subscript(index: Int) -> Todo {
        get {
            return todoList[index]
        }
    }
    
}
