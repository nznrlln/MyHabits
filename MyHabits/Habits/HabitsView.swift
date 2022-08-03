//
//  HabitsView.swift
//  MyHabits
//
//  Created by Нияз Нуруллин on 24.07.2022.
//

import UIKit

class HabitsView: UIView {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.toAutoLayout()
        tableView.backgroundColor = UIColor(named: "CustomGray")
        
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupSubviews()
        setupSubviewsLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        // Чтобы large label не скролился - неообходимо, чтобы tableView была не первой в иерархии. Это также решает проблему неправильного отображения large label при использовании edgeInset у tableView (решается через sizeToFit() и DispatchQueue.main.async во viewWillAppear)
        addSubviews(UIView(frame: .zero), tableView)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func setupTableView(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }

}
