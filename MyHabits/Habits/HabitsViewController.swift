//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Нияз Нуруллин on 24.07.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    let store = HabitsStore.shared

    private lazy var mainView: HabitsView = {
        let view = HabitsView()
        view.toAutoLayout()
        view.setupCollectionView(dataSource: self, delegate: self)

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

    // вызываем тут иначе при возврате к корневой вью настройки сбиваются
    override func viewWillAppear(_ animated: Bool) {
        customizeNavigationBar()
        mainView.updateHabitsList()
    }

    private func viewInitialSettings() {
        view.backgroundColor = .white
        self.title = "Сегодня"

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
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = addButton
    }

    @objc private func addButtonTap() {
        let vc = HabitViewController(habit: nil)
        vc.vcDone = { [weak self] in self?.mainView.updateHabitsList() }
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .overFullScreen
        self.present(nc, animated: true)
    }
   
}


// MARK: - UICollectionViewDataSource

extension HabitsViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return store.habits.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.identifier, for: indexPath) as! ProgressCollectionViewCell
            cell.setupCell(model: store)

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath) as! HabitCollectionViewCell
            cell.setupCell(model: store.habits[indexPath.item])
            cell.checkButtonTapAction = { [weak self] in
                print("Toogle")
                if !(self?.store.habits[indexPath.item].isAlreadyTakenToday)! {
                    self?.store.track((self?.store.habits[indexPath.item])!)
                }
                collectionView.reloadData()

            }
            return cell
        }
    }


}

// MARK: - UICollectionViewFlowLayout

extension HabitsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width - 40, height: 60)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 40, height: 120)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        } else {
            return UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        if indexPath.section != 0 {
            let controller = HabitDetailsViewController(habit: store.habits[indexPath.item])
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    

}
