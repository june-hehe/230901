//
//  DetailViewController.swift
//  TodoCode
//
//  Created by DJ S on 2023/08/28.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MVC패턴을 위한 따로만든 뷰
    private let detailView = DetailView()
    
    // 전화면에서 Todo데이터를 전달 받기 위한 변수
    var todo: Todo?
    
    // 대리자설정을 위한 변수(델리게이트)
    weak var delegate: TodoDelegate?
    
    // MVC패턴을 위해서, view교체
    override func loadView() {
        view = detailView
    }
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupButtonAction()
    }
    
    // 투두를 뷰에 전달⭐️ (뷰에서 알아서 화면 셋팅)
    private func setupData() {
        detailView.todo = todo
    }
    
    // 뷰에 있는 버튼의 타겟 설정
    func setupButtonAction() {
        detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    

    
    
    //MARK: - SAVE버튼 또는 UPDATE버튼이 눌렸을때의 동작
    
    @objc func saveButtonTapped() {
        print("버튼 눌림")
        
        // [1] 투두가 없다면 (새로운 투두를 추가하는 화면)
        if todo == nil {
            // 입력이 안되어 있다면.. (일반적으로) 빈문자열로 저장
            let title = detailView.titleTextField.text ?? ""
            let content = detailView.contentTextField.text ?? ""
            
            // 새로운 투두 (구조체) 생성
            var newTodo =
            Todo(title: title, content: content)
//            print("새멤생성,\(Todo.todoNumbers)")
            // 2) 델리게이트 방식으로 구현⭐️
            delegate?.addNewTodo(newTodo)
            
            
        // [2] 투두가 있다면 (투두의 내용을 업데이트 하기 위한 설정)
        } else {
            let todoId = 0
            todo!.title = detailView.titleTextField.text ?? ""
            todo!.content = detailView.contentTextField.text ?? ""
//            print("수정,\(Todo.todoNumbers)")

            // 델리게이트 방식으로 구현⭐️
            delegate?.update(index: todoId, todo!)
        }
        
        // (일처리를 다한 후에) 전화면으로 돌아가기
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("디테일 뷰컨트롤러 해제")
    }
}


