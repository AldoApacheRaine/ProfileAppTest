//
//  GenderInputTableViewCell.swift
//  ProfileAppTest
//
//  Created by Максим Хмелев on 16.09.2022.
//

import UIKit

class GenderInputTableViewCell: UITableViewCell, UITextFieldDelegate {

    let titleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .none
        textField.textAlignment = .right
        textField.font = .systemFont(ofSize: 18)
        textField.borderStyle = .none
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let genderPicker = UIPickerView()
    weak var delegate: TextCellDelegate?
    static let cellId = "genderInputCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        inputTextField.delegate = self
        inputTextField.inputView = genderPicker
        setupViews()
        setConstraints()
        setupPickerView()
        setTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.endEditing(true)
    }
    
    private func setupPickerView() {
        genderPicker.delegate = self
        genderPicker.dataSource = self
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        contentView.addSubview(inputTextField)
    }
    
    private func setTextField() {
        if ((inputTextField.text?.isEmpty) != nil) {
            inputTextField.text = UserModel.Gender.none.description
        }
    }
    
    func cellConfigure(_ description: String, _ gender: String) {
        titleLabel.text = description
        inputTextField.text = gender
        done()
    }
    
    private func done() {
        let currentCell = self
        self.delegate?.didChangeText(text: inputTextField.text ?? "", for: currentCell)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            inputTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            inputTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -8),
            inputTextField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            inputTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension GenderInputTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        UserModel.Gender.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        UserModel.Gender.allCases[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        inputTextField.text = UserModel.Gender.allCases[row].description
        done()
        inputTextField.resignFirstResponder()
    }
}
