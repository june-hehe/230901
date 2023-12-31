//
//  TodoTableViewController.swift
//  TodoCode
//
//  Created by DJ S on 2023/08/28.
//

import UIKit

final class TodoTableViewController: UIViewController {

    // 테이블뷰
    private let tableView = UITableView()
    
    //MARK: - 관리 모델 선언
    
    // MVC패턴을 위한 데이터 매니저 (배열 관리 - 데이터)
    var todoListManager = TodoListManager()
    
    // 네비게이션바에 넣기 위한 버튼
    lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        return button
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.backgroundColor = .white
        setupNaviBar()
        setupTableView()
        setupDatas()
        setupTableViewConstraints()
    }
    
    // 델리게이트가 아닌 방식으로 구현할때는 화면 리프레시⭐️
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 뷰가 다시 나타날때, 테이블뷰를 리로드
        tableView.reloadData()
    }
    
    func setupNaviBar() {
        title = "메모 목록"
        
        // 네비게이션바 설정관련
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 네비게이션바 오른쪽 상단 버튼 설정
        self.navigationItem.rightBarButtonItem = self.plusButton
    }
    
    //MARK: - 테이블뷰 셋팅
    
    func setupTableView() {

        // 셀의 높이 설정
        tableView.rowHeight = 60
        
        // 셀의 등록⭐️ (타입인스턴스 - 메타타입)
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "TodoCell")
    }
    
    func setupDatas() {
        todoListManager.makeTodoListDatas() // 일반적으로는 서버에 요청
    }
    
    //MARK: - 오토레이아웃 셋팅
    
    // 테이블뷰의 오토레이아웃 설정
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    // 투두를 추가하기 위한 다음 화면으로 이동
    @objc func plusButtonTapped() {
        // 다음화면으로 이동 (투두는 전달하지 않음)
        let detailVC = DetailViewController()
        
        // 다음 화면의 대리자 설정 (다음 화면의 대리자는 지금 현재의 뷰컨트롤러)
        detailVC.delegate = self
        
        // 화면이동
        navigationController?.pushViewController(detailVC, animated: true)
        //show(detailVC, sender: nil)
    }
    
}

//MARK: - 테이블뷰 데이터 소스 구현

extension TodoTableViewController: UITableViewDataSource {
    
    // 1) 테이블뷰에 몇개의 데이터를 표시할 것인지(셀이 몇개인지)를 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListManager.getTodoList().count
    }
    
    // 2) 셀의 구성(셀에 표시하고자 하는 데이터 표시)을 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // (힙에 올라간)재사용 가능한 셀을 꺼내서 사용하는 메서드 (애플이 미리 잘 만들어 놓음)
        // (사전에 셀을 등록하는 과정이 내부 메커니즘에 존재)
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! MyTableViewCell
        
        // 셀에다가 투두를 전달 (투두만 전달하면, 화면에 표시하도록 구현⭐️ 셀에서 didSet으로)
        cell.todo = todoListManager[indexPath.row]
        cell.selectionStyle = .none
        print("todoLists Manager : \(todoListManager[indexPath.row])")
        return cell
    }
}

//MARK: - 테이블뷰 델리게이트 구현 (셀이 선택되었을때)

extension TodoTableViewController: UITableViewDelegate {
    
    // 셀이 선택이 되었을때 어떤 동작을 할 것인지 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 다음화면으로 이동
        let detailVC = DetailViewController()
        
        // 다음 화면의 대리자 설정 (다음 화면의 대리자는 지금 현재의 뷰컨트롤러)
        detailVC.delegate = self
        
        // 다음 화면에 투두를 전달
        let currentTodo = todoListManager.getTodoList()[indexPath.row]
        detailVC.todo = currentTodo
        
        // 화면이동
        navigationController?.pushViewController(detailVC, animated: true)
        //show(detailVC, sender: nil)
    }
}

//MARK: - 투두 추가하거나, 업데이트에 대한 델리게이트 구현

extension TodoTableViewController: TodoDelegate {
    // 투두가 추가되면 실행할 메서드 구현
    func addNewTodo(_ todo: Todo) {
        // 모델에 투두 추가
        todoListManager.makeNewTodo(todo)
        // 테이블뷰를 다시 로드 (다시 그리기)
        tableView.reloadData()
    }
    
    // 투두의 정보가 업데이트 되면 실행할 메서드 구현
    func update(index: Int, _ todo: Todo) {
        print("업데이트")
        // 모델에 투두 정보 업데이트
        todoListManager.updateTodoInfo(index: index, todo)
        // 테이블뷰를 다시 로드 (다시 그리기)
        tableView.reloadData()
    }
}
