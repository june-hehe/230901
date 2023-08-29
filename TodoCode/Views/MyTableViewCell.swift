//
//  MyTableViewCell.swift
//  TodoCode
//
//  Created by DJ S on 2023/08/28.
//

import UIKit

final class MyTableViewCell: UITableViewCell {

    //MARK: - 투두 저장속성 구현
    // 투두가 변할때마다 자동으로 업데이트 되도록 구현 didSet(속성 감시자) ⭐️
    var todo: Todo? {
        didSet {
            guard var todo = todo else { return }
            todoNameLabel.text = todo.title
            todoContentLabel.text = todo.content
        }
    }
    
    //MARK: - UI구현
    

    let todoNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let todoContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution  = .fill
        sv.alignment = .fill
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    //MARK: - 생성자 셋팅
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupStackView()
        
        // 셀 오토레이아웃 일반적으로 생성자에서 잡으면 됨 ⭐️⭐️⭐️
        setConstraints()
    }
    
    func setupStackView() {

        self.contentView.addSubview(stackView)
        
        // 스택뷰 위에 뷰들 올리기
        stackView.addArrangedSubview(todoNameLabel)
        stackView.addArrangedSubview(todoContentLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 오토레이아웃 셋팅
    // (오토레이아웃 변하지 않는 경우) 일반적으로 생성자에서 잡으면 됨 ⭐️⭐️⭐️
//    override func updateConstraints() {
//        setConstraints()
//        super.updateConstraints()
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            todoNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            
            // self.trailingAnchor로 잡는 것보다 self.contentView.trailingAnchor로 잡는게 더 정확함 ⭐️
            // (cell은 기본뷰로 contentView를 가지고 있기 때문)
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
