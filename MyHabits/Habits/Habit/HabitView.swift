//
//  HabitView.swift
//  MyHabits
//
//  Created by Нияз Нуруллин on 28.07.2022.
//

import UIKit

protocol HabitViewDelegate: AnyObject {
    func colorPickerButtonTapAction()
    func deleteButtonTapAction()
}

class HabitView: UIView {

    private var habit: Habit?

    let store = HabitsStore.shared

    var delegate: HabitViewDelegate?

    let formatter = DateFormatter()

    private let habitNameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "НАЗВАНИЕ"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)

        return label
    }()

    private let habitDiscriptionField: CustomUITextField = {
        let textField = CustomUITextField()
        textField.toAutoLayout()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."

        return textField
    }()

    private let colorLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "ЦВЕТ"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)

        return label
    }()

    private lazy var colorPickerButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.backgroundColor = .black
        button.layer.cornerRadius = HabitConstants.colorPickerButtonHeight / 2
        button.addTarget(self, action: #selector(colorPickerButtonTap), for: .touchUpInside)

        return button
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "ВРЕМЯ"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)

        return label
    }()

    private let timeTextLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Каждый день в "
        label.font = UIFont(name: "SFProText-Regular", size: 17)

        return label
    }()

    private let timePickerLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textColor = UIColor(named: "CustomViolet")
        label.text = "11:00 PM"
        label.font = UIFont(name: "SFProText-Regular", size: 17)

        return label
    }()

    private lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.toAutoLayout()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.addTarget(self, action: #selector(updateTimePickerLabel), for: .valueChanged)

        formatter.dateFormat = "HH:mm"
        timePicker.date = formatter.date(from: "23:00")!

        return timePicker
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTap), for: .touchUpInside)
        button.isHidden = true

        return button
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
        self.addSubviews(
            habitNameLabel,
            habitDiscriptionField,
            colorLabel,
            colorPickerButton,
            timeLabel,
            timeTextLabel,
            timePickerLabel,
            timePicker,
            deleteButton
        )
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            habitNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: HabitConstants.topInset),
            habitNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: HabitConstants.leadingInset),

            habitDiscriptionField.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: HabitConstants.spacingInset),
            habitDiscriptionField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: HabitConstants.leadingInset),
            habitDiscriptionField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: HabitConstants.trailingInset),
            habitDiscriptionField.heightAnchor.constraint(equalToConstant: 20),

            colorLabel.topAnchor.constraint(equalTo: habitDiscriptionField.bottomAnchor, constant: HabitConstants.topInset),
            colorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: HabitConstants.leadingInset),

            colorPickerButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: HabitConstants.spacingInset),
            colorPickerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: HabitConstants.leadingInset),
            colorPickerButton.heightAnchor.constraint(equalToConstant: HabitConstants.colorPickerButtonHeight),
            colorPickerButton.widthAnchor.constraint(equalTo: colorPickerButton.heightAnchor),

            timeLabel.topAnchor.constraint(equalTo: colorPickerButton.bottomAnchor, constant: HabitConstants.topInset),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: HabitConstants.leadingInset),

            timeTextLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: HabitConstants.spacingInset),
            timeTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: HabitConstants.leadingInset),

            timePickerLabel.topAnchor.constraint(equalTo: timeTextLabel.topAnchor),
            timePickerLabel.leadingAnchor.constraint(equalTo: timeTextLabel.trailingAnchor),

            timePicker.topAnchor.constraint(equalTo: timeTextLabel.bottomAnchor, constant: HabitConstants.spacingInset),
            timePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: HabitConstants.leadingInset),
            timePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            deleteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: HabitConstants.bottomInset)
        ])
    }

    func showHabitData(habit: Habit) {
        habitDiscriptionField.text = habit.name
        colorPickerButton.backgroundColor = habit.color
        timePicker.date = habit.date
        updateTimePickerLabel()
        deleteButton.isHidden = false
        self.habit = habit
    }

    func updateColorPickerButton(_ color: UIColor) {
        colorPickerButton.backgroundColor = color
    }

    func saveHabit(_ color: UIColor) {
        if habit == nil{
            let newHabit = Habit(name: habitDiscriptionField.text!, // передать из uitext field
                                 date: timePicker.date, // передать из datepicker или через formatter из label
                                 color: color) // передать из colorpicker
            store.habits.append(newHabit)
        } else {
            let index = store.habits.firstIndex(of: habit!)
            store.habits[index!].name = habitDiscriptionField.text!
            store.habits[index!].date = timePicker.date
            store.habits[index!].color = color
        }

    }

    @objc func updateTimePickerLabel() {
        formatter.dateFormat = "HH:mm a"
        timePickerLabel.text = formatter.string(from: self.timePicker.date)
    }

    @objc private func colorPickerButtonTap() {
        delegate?.colorPickerButtonTapAction()
    }

    @objc private func deleteButtonTap() {
        delegate?.deleteButtonTapAction()
    }

}
