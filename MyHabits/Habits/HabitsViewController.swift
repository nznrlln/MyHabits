//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Нияз Нуруллин on 24.07.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    private lazy var mainView: HabitsView = {
        let view = HabitsView()
        view.toAutoLayout()
        view.setupTableView(dataSource: self, delegate: self)

        return view
    }()

    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTap))
        button.tintColor = UIColor(named: "CustomViolet")

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewInitialSettings()
    }

    private func viewInitialSettings() {
        view.backgroundColor = .white
        setupSubviews()
        setupSubviewsLayout()
        customizeNavigationBar()
    }

    private func setupSubviews() {
        mainView.setupTableView(dataSource: self, delegate: self)
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
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Сегодня"
        self.navigationItem.rightBarButtonItem = addButton
    }

    @objc private func addButtonTap() {
        let vc = HabitViewController()
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .overFullScreen
        self.present(nc, animated: true)
    }

    private let progressBar: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .bar)
        progressBar.toAutoLayout()

        return progressBar
    }()
   
}


// MARK: - UITableViewDataSource

extension HabitsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            var content: UIListContentConfiguration = cell.defaultContentConfiguration()
            content.text = "Future progress bar"
            cell.contentConfiguration = content

            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            var content: UIListContentConfiguration = cell.defaultContentConfiguration()
            content.text = "Секция: \(indexPath.section)"
            content.secondaryText = "ячейка: \(indexPath.row)"
            cell.contentConfiguration = content

            return cell
        }

    }


}

// MARK: - UITableViewDataSource

extension HabitsViewController: UITableViewDelegate {


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
