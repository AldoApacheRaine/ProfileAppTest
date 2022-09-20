//
//  TextInputTableViewCell.swift
//  ProfileAppTest
//
//  Created by Максим Хмелев on 16.09.2022.
//

import UIKit

protocol TextCellDelegate: AnyObject {
    func didChangeText(text: String, for cell: UITableViewCell)
}

class TextInputTableViewCell: UITableViewCell, UITextViewDelegate {
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let inputTextView: UITextView = {
       let textView = UITextView()
        textView.textAlignment = .right
        textView.font = .systemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    weak var delegate: TextCellDelegate?
    static let cellId = "textInputCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        inputTextView.delegate = self
        addDoneButton()
        setupViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func doneButtonAction() {
        done()
        self.inputTextView.resignFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        done()
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        contentView.addSubview(inputTextView)
    }
    
    func cellConfigure(_ description: String, _ value: String) {
        titleLabel.text = description
        inputTextView.text = value
        done()
    }
    
    private func addDoneButton() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputTextView.inputAccessoryView = doneToolbar
    }
    
    private func done() {
        let currentCell = self
        self.delegate?.didChangeText(text: inputTextView.text ?? "", for: currentCell)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            inputTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            inputTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5, constant: -8),
            inputTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            inputTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
