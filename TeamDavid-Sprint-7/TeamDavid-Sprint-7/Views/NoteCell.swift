//
//  NoteCell.swift
//  TeamDavid-Sprint-7
//
//  Created by David Doswell on 12/26/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class NoteCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let date = Date()
    let formatter = DateFormatter()
    
    let titleTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setUpViews() {
        
        backgroundColor = Appearance.customBackground
        
        addSubview(titleTextLabel)
        addSubview(descriptionLabel)
        addSubview(dateLabel)
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 2
        
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        dateLabel.text = formatter.string(from: date)
        
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        titleTextLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30).isActive = true
        titleTextLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleTextLabel.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        titleTextLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant: 20).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 175).isActive = true
    }
    
}
