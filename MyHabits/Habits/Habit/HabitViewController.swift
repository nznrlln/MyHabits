//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Нияз Нуруллин on 28.07.2022.
//

import UIKit

class HabitViewController: UIViewController {

    private var habit: Habit?

    let store = HabitsStore.shared

    var vcDone: (() -> Void)?

    private var color: UIColor?

    private lazy var mainView: HabitView = {
        let view = HabitView()
        view.toAutoLayout()
        view.delegate = self

        return view
    }()

    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButtonTap))

        return button
    }()

    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonTap))

        return button
    }()

    init(habit: Habit?) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if habit == nil {
            viewInitialSettings()
        } else {
            editViewInitialSettings()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        customizeNavigationBar()
    }

    private func viewInitialSettings() {
        view.backgroundColor = UIColor(named: "CustomGray")
        self.title = "Создать"

        setupSubviews()
        setupSubviewsLayout()
    }

    private func editViewInitialSettings() {
        view.backgroundColor = UIColor(named: "CustomGray")
        self.title = "Править"
        color = habit?.color

        setupSubviews()
        setupSubviewsLayout()
        mainView.showHabitData(habit: habit!)
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
        navigationController?.navigationBar.tintColor = UIColor(named: "CustomViolet")
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
    }

    @objc private func cancelButtonTap() {
        self.dismiss(animated: true)
    }

    @objc private func saveButtonTap() {
        mainView.saveHabit(color ?? .black)
        self.dismiss(animated: true)
        self.vcDone?()
    }
}


// MARK: - HabitViewDelegate
extension HabitViewController:HabitViewDelegate {

    func colorPickerButtonTapAction() {
        let vc = UIColorPickerViewController()
        vc.delegate = self
        vc.selectedColor = color ?? .black
        self.present(vc, animated: true)
    }
    
    func deleteButtonTapAction() {
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку *название выбранной привычки*?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            print("Отмена")
        }
        let closeAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            print("Удалить привычку")
            self.store.habits.removeAll(where: { $0 == self.habit })
            self.dismiss(animated: true, completion: nil)
            self.vcDone?()
        }

        alert.addAction(cancelAction)
        alert.addAction(closeAction)

        present(alert, animated: true, completion: nil)
    }

}

// MARK: - UIColorPickerViewControllerDelegate

extension HabitViewController: UIColorPickerViewControllerDelegate {

    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        mainView.updateColorPickerButton(viewController.selectedColor)
    }

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.color = viewController.selectedColor
    }
}
