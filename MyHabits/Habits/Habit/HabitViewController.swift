//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Нияз Нуруллин on 28.07.2022.
//

import UIKit

class HabitViewController: UIViewController {

    private let mainView: HabitView = {
        let view = HabitView()
        view.toAutoLayout()

        return view
    }()

    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButtonTap))
        button.tintColor = UIColor(named: "CustomViolet")

        return button
    }()

    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonTap))
        button.tintColor = UIColor(named: "CustomViolet")

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewInitialSettings()
    }

    private func viewInitialSettings() {
        view.backgroundColor = UIColor(named: "CustomGray")
        setupSubviews()
        setupSubviewsLayout()
        customizeNavigationBar()
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
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backgroundColor = UIColor(named: "CustomGray")
        self.title = "Создать"
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
    }

    @objc private func cancelButtonTap() {
        self.dismiss(animated: true)
    }

    @objc private func saveButtonTap() {
        self.dismiss(animated: true)
    }
}
