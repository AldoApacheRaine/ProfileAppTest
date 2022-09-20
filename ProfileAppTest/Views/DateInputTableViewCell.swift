//
//  DateInputTableViewCell.swift
//  ProfileAppTest
//
//  Created by Максим Хмелев on 16.09.2022.
//

import UIKit

class DateInputTableViewCell: UITableViewCell {

    let titleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
       let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.maximumDate = Date()
        picker.addTarget(self, action: #selector(pickerChanged), for: .valueChanged)
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    weak var delegate: TextCellDelegate?
    static let cellId = "dateInputCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        contentView.addSubview(datePicker)
    }
    
    @objc private func pickerChanged() {
        let currentCell = self
        self.delegate?.didChangeText(text: dateFormatter.string(from: datePicker.date), for: currentCell)
    }
    
    func cellConfigure(_ description: String, _ date: Date) {
        titleLabel.text = description
        datePicker.setDate(date, animated: true)
        pickerChanged()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            datePicker.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -8),
            datePicker.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            datePicker.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
