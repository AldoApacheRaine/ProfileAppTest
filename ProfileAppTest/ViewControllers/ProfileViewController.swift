//
//  ProfileViewController.swift
//  ProfileAppTest
//
//  Created by Максим Хмелев on 14.09.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let userTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var userData = [String]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Просмотр"
        view.backgroundColor = .white
        setupViews()
        setConstraints()
        setTableView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Редактировать", style: .plain, target: self, action: #selector(self.editButtonTapped))
        setValues()
    }
    
    private func setupViews() {
        view.addSubview(userTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setValues()
        userTableView.reloadData()
    }
    
    private func setTableView() {
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.register(ProfiletableViewCell.self, forCellReuseIdentifier: ProfiletableViewCell.cellId)
        
    }
    
    private func setValues() {
        let userDefaults = UserDefaults.standard
        let data = userDefaults.object(forKey: "UserData")
        if data == nil {
            userData.append("Имя")
            userData.append("Фамилия")
            userData.append("Отчество")
            userData.append("01.01.1990")
            userData.append("Мужской")
            userDefaults.set(userData, forKey: "UserData")
        } else {
            userData = data as! [String]
        }
    }
    
    @objc func editButtonTapped(){
        let viewController = EditViewController()
        navigationController?.pushViewController(viewController, animated: true)        
    }
}

// MARK: - TableViewDelegate, TableViewDataSource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UserModel.FieldsTypes.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProfiletableViewCell.cellId, for: indexPath) as? ProfiletableViewCell {
            cell.titleLabel.text = UserModel.FieldsTypes.allCases[indexPath.row].description
            cell.valueLabel.text = userData[indexPath.row]
            if indexPath.row == 1 {
                cell.valueLabel.numberOfLines = 0
            }
            return cell
        }
         return UITableViewCell()
    }
}

// MARK: - SetConstraints
extension ProfileViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userTableView.topAnchor.constraint(equalTo: view.topAnchor),
            userTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

