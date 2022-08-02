//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Нияз Нуруллин on 31.07.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    let store = HabitsStore.shared

    private let habit: Habit

    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editButtonTap))

        return button
    }()

    private lazy var mainView: HabitDetailsView = {
        let view = HabitDetailsView()
        view.toAutoLayout()
        view.setupTableView(dataSource: self, delegate: self)

        return view
    }()

    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewInitialSettings()
    }

    override func viewWillAppear(_ animated: Bool) {
        customizeNavigationBar()
    }

    private func viewInitialSettings() {
        view.backgroundColor = .systemGray5
        self.title = habit.name

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        view.addSubview(mainView)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func customizeNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .systemGray5
        navigationController?.navigationBar.tintColor = UIColor(named: "CustomViolet")
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.rightBarButtonItem = editButton

    }

    @objc private func editButtonTap() {
        let vc = HabitViewController(habit: self.habit)
        vc.vcDone = { [weak self] in self?.navigationController?.popViewController(animated: true) }
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .overFullScreen
        self.present(nc, animated: true)
    }

}

// MARK: - UITableViewDataSource

extension HabitDetailsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.dates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var content: UIListContentConfiguration = cell.defaultContentConfiguration()

        let reversedIndex = store.dates.count - indexPath.row - 1
        content.text = store.trackDateString(forIndex: reversedIndex)
        cell.contentConfiguration = content

        var image = UIImage()
        if store.habit(habit, isTrackedIn: store.dates[reversedIndex]) {
            image = UIImage(systemName: "checkmark")!
            image.withTintColor(UIColor(named: "CustomViolet")!)
        }
        cell.accessoryView = UIImageView(image: image)
        cell.accessoryView?.tintColor = UIColor(named: "CustomViolet")
        
        return cell
    }


}

// MARK: - UITableViewDataSource

extension HabitDetailsViewController: UITableViewDelegate {


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: HabitDetailsHeaderView = {
            let header = HabitDetailsHeaderView()
            header.toAutoLayout()

            return header
        }()
    
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //        UITableView.automaticDimension
        return 20
    }


}
