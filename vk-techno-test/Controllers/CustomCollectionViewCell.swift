//
//  CustomCollectionViewCell.swift
//  vk-techno-test
//
//  Created by Marina Kolbina on 22/07/2024.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBlue
        contentView.addSubview(imageView)
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            button.widthAnchor.constraint(equalToConstant: 80),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String?, tag: Int?, imageName: String?) {
        if let title = title, let tag = tag {
            button.setTitle(title, for: .normal)
            button.tag = tag
            button.isHidden = false
        } else {
            button.isHidden = true
        }
        
        if let imageName = imageName {
            imageView.image = UIImage(named: imageName)
        } else {
            imageView.image = nil
        }
    }
    
    func setButtonTarget(target: Any?, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }
}
