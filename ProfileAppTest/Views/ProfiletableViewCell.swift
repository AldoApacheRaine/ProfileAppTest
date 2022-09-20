//
//  ProfiletableViewCell.swift
//  ProfileAppTest
//
//  Created by Максим Хмелев on 15.09.2022.
//

import UIKit

class ProfiletableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let valueLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .right
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let cellId = "profileCell"
    
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
        addSubview(valueLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            valueLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -8),
            valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

}
