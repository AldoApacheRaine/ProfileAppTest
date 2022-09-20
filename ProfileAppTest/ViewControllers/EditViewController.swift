//
//  EditViewController.swift
//  ProfileAppTest
//
//  Created by Максим Хмелев on 15.09.2022.
//

import UIKit

class EditViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private let editTableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var user = UserModel()
    private var userData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setConstraints()
        setTableView()
        setValues()
        setNavController()
        setGesture()
    }
    
    @objc private func saveButtonTapped() {
       saveData()
    }
    
    @objc private func backButtonTapped() {
        if user.dataChanged() {
            let message = "Данные были изменены. Вы желаете сохранить изменения, в противном случае внесенные правки будут отменены."
            let alertError = UIAlertController(title: "Данные были изменены.", message: message, preferredStyle: UIAlertController.Style.alert)
            alertError.addAction(UIAlertAction(title: "Сохранить", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                self.saveData()
            }))
            alertError.addAction(UIAlertAction(title: "Пропустить", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alertError, animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupViews() {
        view.addSubview(editTableView)
    }
    
    private func setTableView() {
        editTableView.delegate = self
        editTableView.dataSource = self
        editTableView.register(TextInputTableViewCell.self, forCellReuseIdentifier: TextInputTableViewCell.cellId)
        editTableView.register(DateInputTableViewCell.self, forCellReuseIdentifier: DateInputTableViewCell.cellId)
        editTableView.register(GenderInputTableViewCell.self, forCellReuseIdentifier: GenderInputTableViewCell.cellId)
    }
    
    private func saveData() {
        if user.validate() {
            user.saveUser(model: user)
            self.navigationController?.popViewController(animated: true)
        } else {
            let message = "Пожалуйста, заполните все поля (отчество опционально)"
            let alertError = UIAlertController(title: "Ошибка", message: message, preferredStyle: UIAlertController.Style.alert)
            alertError.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertError, animated: true, completion: nil)
        }
    }
    
    private func setValues() {
        let userDefaults = UserDefaults.standard
        userData = userDefaults.object(forKey: "UserData") as! [String]
    }
    
    private func setNavController() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(self.saveButtonTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(self.backButtonTapped))
    }
    
    private func setGesture() {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(backButtonTapped))
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    private func setDate(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        return Date()
    }
}

// MARK: - TableViewDelegate, TableViewDataSource

extension EditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UserModel.FieldsTypes.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fieldsDescription = UserModel.FieldsTypes.allCases[indexPath.row].description
        let user = userData[indexPath.row]
        switch indexPath.row {
        case 0...2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextInputTableViewCell.cellId, for: indexPath) as? TextInputTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.cellConfigure(fieldsDescription, user)
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DateInputTableViewCell.cellId, for: indexPath) as? DateInputTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.cellConfigure(fieldsDescription, setDate(user))
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GenderInputTableViewCell.cellId, for: indexPath) as? GenderInputTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.cellConfigure(fieldsDescription, user)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

// MARK: - TextCellDelegate
extension EditViewController: TextCellDelegate {
    func didChangeText(text: String, for cell: UITableViewCell) {
        guard let index = self.editTableView.indexPath(for: cell) else { return }
        switch index {
        case [0,0]:
            user.name = text
        case [0,1]:
            user.surname = text
        case [0,2]:
            user.patronymic = text
        case [0,3]:
            user.birthDate = text
        case [0,4]:
            user.gender = text
        default:
            break
        }
    }
}

// MARK: - SetConstraints
extension EditViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            editTableView.topAnchor.constraint(equalTo: view.topAnchor),
            editTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
